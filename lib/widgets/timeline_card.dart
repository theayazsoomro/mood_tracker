import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/mood_entry.dart';
import 'mood_face.dart';

class TimelineCard extends StatelessWidget {
  final MoodEntry entry;

  const TimelineCard({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getMoodColor(entry.type);

    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateFormat('E, d').format(entry.date),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 12),
          MoodFace(mood: entry.type, size: 36, color: color),
          const SizedBox(height: 8),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
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
}
