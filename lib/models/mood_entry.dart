import 'package:flutter/material.dart';

enum MoodType { happy, neutral, sad, angry, frustrated }

extension MoodTypeExtension on MoodType {
  Color get color {
    switch (this) {
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

  String get label {
    switch (this) {
      case MoodType.happy:
        return 'Happy';
      case MoodType.neutral:
        return 'Neutral';
      case MoodType.sad:
        return 'Sad';
      case MoodType.angry:
        return 'Angry';
      case MoodType.frustrated:
        return 'Frustrated';
    }
  }
}

class MoodEntry {
  final MoodType type;
  final DateTime date;

  MoodEntry({required this.type, required this.date});
}
