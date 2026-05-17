import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import '../painters/mood_painter.dart';

/// A widget that renders a custom painted face based on the [MoodType].
class MoodFace extends StatelessWidget {
  final MoodType mood;
  final double size;
  final Color? color;

  const MoodFace({super.key, required this.mood, this.size = 100, this.color});

  @override
  Widget build(BuildContext context) {
    // Use provided color or fallback to the mood's default color
    final effectiveColor = color ?? mood.color;

    return CustomPaint(
      size: Size(size, size),
      painter: MoodPainter(mood: mood, color: effectiveColor),
    );
  }
}
