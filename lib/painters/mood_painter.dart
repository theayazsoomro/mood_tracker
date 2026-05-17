import 'dart:math';
import 'package:flutter/material.dart';
import '../models/mood_entry.dart';

class MoodPainter extends CustomPainter {
  final MoodType mood;
  final Color color;

  MoodPainter({required this.mood, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    // Main stroke paint for face outlines and features
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06
      ..strokeCap = StrokeCap.round;

    // Subtle fill for the face background
    final fillPaint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    // Draw Face Circle
    canvas.drawCircle(center, radius, fillPaint);
    canvas.drawCircle(center, radius, paint);

    // Common Eye Parameters
    final eyeOffsetX = radius * 0.35;
    final eyeOffsetY = radius * 0.2;
    final eyeRadius = radius * 0.08;

    _drawEyes(canvas, center, eyeOffsetX, eyeOffsetY, eyeRadius, paint);
    _drawBrows(canvas, center, radius, eyeOffsetX, eyeOffsetY, paint);
    _drawMouth(canvas, center, radius, paint);
  }

  void _drawEyes(Canvas canvas, Offset center, double offsetX, double offsetY, double eyeRadius, Paint paint) {
    final eyeFill = Paint()
      ..color = paint.color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(center.dx - offsetX, center.dy - offsetY), eyeRadius, eyeFill);
    canvas.drawCircle(Offset(center.dx + offsetX, center.dy - offsetY), eyeRadius, eyeFill);
  }

  void _drawBrows(Canvas canvas, Offset center, double radius, double offsetX, double offsetY, Paint paint) {
    final browWidth = radius * 0.3;
    final browHeight = radius * 0.1;
    final browTop = center.dy - offsetY - radius * 0.15;

    switch (mood) {
      case MoodType.happy:
        _drawCurve(canvas, Offset(center.dx - offsetX - browWidth / 2, browTop),
            Offset(center.dx - offsetX + browWidth / 2, browTop), -0.1, paint);
        _drawCurve(canvas, Offset(center.dx + offsetX - browWidth / 2, browTop),
            Offset(center.dx + offsetX + browWidth / 2, browTop), -0.1, paint);
        break;
      case MoodType.neutral:
        canvas.drawLine(Offset(center.dx - offsetX - browWidth / 2, browTop),
            Offset(center.dx - offsetX + browWidth / 2, browTop), paint);
        canvas.drawLine(Offset(center.dx + offsetX - browWidth / 2, browTop),
            Offset(center.dx + offsetX + browWidth / 2, browTop), paint);
        break;
      case MoodType.sad:
        canvas.drawLine(Offset(center.dx - offsetX - browWidth / 2, browTop + browHeight),
            Offset(center.dx - offsetX + browWidth / 2, browTop), paint);
        canvas.drawLine(Offset(center.dx + offsetX - browWidth / 2, browTop),
            Offset(center.dx + offsetX + browWidth / 2, browTop + browHeight), paint);
        break;
      case MoodType.angry:
        canvas.drawLine(Offset(center.dx - offsetX - browWidth / 2, browTop - browHeight),
            Offset(center.dx - offsetX + browWidth / 2, browTop + browHeight), paint);
        canvas.drawLine(Offset(center.dx + offsetX - browWidth / 2, browTop + browHeight),
            Offset(center.dx + offsetX + browWidth / 2, browTop - browHeight), paint);
        break;
      case MoodType.frustrated:
        canvas.drawLine(Offset(center.dx - offsetX - browWidth / 2, browTop - browHeight * 0.5),
            Offset(center.dx - offsetX + browWidth / 2, browTop + browHeight * 0.5), paint);
        canvas.drawLine(Offset(center.dx + offsetX - browWidth / 2, browTop - browHeight * 0.5),
            Offset(center.dx + offsetX + browWidth / 2, browTop + browHeight * 0.5), paint);
        break;
    }
  }

  void _drawMouth(Canvas canvas, Offset center, double radius, Paint paint) {
    final mouthWidth = radius * 0.5;
    final mouthY = center.dy + radius * 0.35;

    switch (mood) {
      case MoodType.happy:
        final rect = Rect.fromCenter(center: Offset(center.dx, mouthY), width: mouthWidth, height: radius * 0.4);
        canvas.drawArc(rect, 0, pi, false, paint);
        break;
      case MoodType.neutral:
        canvas.drawLine(Offset(center.dx - mouthWidth / 2, mouthY), Offset(center.dx + mouthWidth / 2, mouthY), paint);
        break;
      case MoodType.sad:
        final rect = Rect.fromCenter(center: Offset(center.dx, mouthY + radius * 0.1), width: mouthWidth, height: radius * 0.3);
        canvas.drawArc(rect, pi, pi, false, paint);
        break;
      case MoodType.angry:
        final rect = Rect.fromCenter(center: Offset(center.dx, mouthY + radius * 0.1), width: mouthWidth * 0.7, height: radius * 0.2);
        canvas.drawArc(rect, pi, pi, false, paint);
        break;
      case MoodType.frustrated:
        final path = Path()
          ..moveTo(center.dx - mouthWidth / 2, mouthY)
          ..quadraticBezierTo(center.dx - mouthWidth / 4, mouthY - radius * 0.1, center.dx, mouthY)
          ..quadraticBezierTo(center.dx + mouthWidth / 4, mouthY + radius * 0.1, center.dx + mouthWidth / 2, mouthY);
        canvas.drawPath(path, paint);
        break;
    }
  }

  void _drawCurve(Canvas canvas, Offset start, Offset end, double bend, Paint paint) {
    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..quadraticBezierTo((start.dx + end.dx) / 2, start.dy + (end.dx - start.dx) * bend, end.dx, end.dy);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant MoodPainter oldDelegate) =>
      oldDelegate.mood != mood || oldDelegate.color != color;
}
