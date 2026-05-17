import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import '../painters/mood_painter.dart';

class MoodFace extends StatelessWidget {
  final MoodType mood;
  final double size;
  final Color? color;

  const MoodFace({
    super.key,
    required this.mood,
    this.size = 100,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? _getColorForMood(mood, Theme.of(context).colorScheme);
    
    return CustomPaint(
      size: Size(size, size),
      painter: MoodPainter(
        mood: mood,
        color: effectiveColor,
      ),
    );
  }

  Color _getColorForMood(MoodType mood, ColorScheme colorScheme) {
    switch (mood) {
      case MoodType.happy:
        return Colors.amber;
      case MoodType.neutral:
        return Colors.blueGrey;
      case MoodType.sad:
        return Colors.blue;
      case MoodType.angry:
        return Colors.red;
      case MoodType.frustrated:
        return Colors.orange;
    }
  }
}
