import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import 'mood_face.dart';

class MoodCard extends StatefulWidget {
  final MoodType type;
  final VoidCallback onTap;

  const MoodCard({
    super.key,
    required this.type,
    required this.onTap,
  });

  @override
  State<MoodCard> createState() => _MoodCardState();
}

class _MoodCardState extends State<MoodCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.92,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnimation = _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getMoodColor(MoodType type) {
    switch (type) {
      case MoodType.happy: return Colors.amber;
      case MoodType.neutral: return Colors.blueGrey;
      case MoodType.sad: return Colors.blue;
      case MoodType.angry: return Colors.red;
      case MoodType.frustrated: return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getMoodColor(widget.type);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => _controller.reverse(),
        onTapUp: (_) {
          _controller.forward();
          widget.onTap();
        },
        onTapCancel: () => _controller.forward(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            width: 150,
            decoration: BoxDecoration(
              color: _isHovered 
                  ? color.withValues(alpha: 0.08)
                  : Colors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: _isHovered ? color.withValues(alpha: 0.5) : Colors.transparent,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: _isHovered ? 0.2 : 0.05),
                  blurRadius: _isHovered ? 25 : 15,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MoodFace(mood: widget.type, size: 70, color: color),
                const SizedBox(height: 20),
                Text(
                  widget.type.name.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    letterSpacing: 1.5,
                    color: _isHovered ? color : const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
