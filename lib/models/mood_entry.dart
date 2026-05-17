enum MoodType {
  happy,
  neutral,
  sad,
  angry,
  frustrated,
}

class MoodEntry {
  final MoodType type;
  final DateTime date;

  MoodEntry({
    required this.type,
    required this.date,
  });
}
