import 'dart:collection';
import 'package:flutter/material.dart';
import '../models/mood_entry.dart';

class MoodProvider with ChangeNotifier {
  static const int _maxEntries = 7;

  // Mock data for mood entries
  final List<MoodEntry> _entries = [
    MoodEntry(
      type: MoodType.happy,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
    MoodEntry(
      type: MoodType.neutral,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    MoodEntry(
      type: MoodType.sad,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    MoodEntry(
      type: MoodType.angry,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    MoodEntry(
      type: MoodType.frustrated,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    MoodEntry(
      type: MoodType.happy,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  /// Returns an unmodifiable list of mood entries.
  UnmodifiableListView<MoodEntry> get entries => UnmodifiableListView(_entries);

  /// Adds a new mood entry and ensures only the latest [_maxEntries] are kept.
  void addMood(MoodType type) {
    _entries.add(MoodEntry(type: type, date: DateTime.now()));
    _enforceMaxEntries();
    notifyListeners();
  }

  void _enforceMaxEntries() {
    while (_entries.length > _maxEntries) {
      _entries.removeAt(0);
    }
  }

  /// Clears all mood entries.
  void clearEntries() {
    _entries.clear();
    notifyListeners();
  }
}
