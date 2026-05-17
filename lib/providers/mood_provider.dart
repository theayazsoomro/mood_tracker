import 'dart:collection';
import 'package:flutter/material.dart';
import '../models/mood_entry.dart';

class MoodProvider with ChangeNotifier {
  // Mock data for mood entries
  final List<MoodEntry> _entries = [
    MoodEntry(type: MoodType.happy, date: DateTime.now().subtract(const Duration(days: 6))),
    MoodEntry(type: MoodType.neutral, date: DateTime.now().subtract(const Duration(days: 5))),
    MoodEntry(type: MoodType.sad, date: DateTime.now().subtract(const Duration(days: 4))),
    MoodEntry(type: MoodType.angry, date: DateTime.now().subtract(const Duration(days: 3))),
    MoodEntry(type: MoodType.frustrated, date: DateTime.now().subtract(const Duration(days: 2))),
    MoodEntry(type: MoodType.happy, date: DateTime.now().subtract(const Duration(days: 1))),
  ];

  UnmodifiableListView<MoodEntry> get entries => UnmodifiableListView(_entries);

  void addMood(MoodType type) {
    _entries.add(MoodEntry(type: type, date: DateTime.now()));
    if (_entries.length > 7) {
      _entries.removeAt(0);
    }
    notifyListeners();
  }
}
