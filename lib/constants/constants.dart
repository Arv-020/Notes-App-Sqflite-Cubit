import 'package:flutter/material.dart';

import '../models/notes_model.dart';

class NotesData extends ValueNotifier<List<NotesModel>> {
  NotesData._instance() : super([]);
  static final NotesData _noteInstance = NotesData._instance();
  factory NotesData() => _noteInstance;
  int get length => value.length;

  void addNote(NotesModel note) {
    value.add(note);
    notifyListeners();
  }

  int id = 1;
  void removeNote(NotesModel note) {
    value.add(note);
    notifyListeners();
  }

  NotesModel? getIndex(int index) => value[index];
}
