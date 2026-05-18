import 'dart:collection';
import 'package:flutter/material.dart';
import '../models/mood_entry.dart';

class MoodProvider with ChangeNotifier {
  static const int _maxEntries = 7;

  // Mock data for mood entries
  final List<MoodEntry> _entries = [];

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
