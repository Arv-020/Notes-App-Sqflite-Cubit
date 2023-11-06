import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/notes_model.dart';

class NotesProvider extends ChangeNotifier {
  // named constructor
  NotesProvider._instance();
  static final NotesProvider _noteInstance = NotesProvider._instance();
  factory NotesProvider() => _noteInstance;

  //list of notes
  final List<NotesModel> _items = [];
  UnmodifiableListView<NotesModel> get items => UnmodifiableListView(_items);

  //number of notes
  int get length => items.length;

  void addNote(NotesModel note) {
    _items.add(note);
    notifyListeners();
  }

  void removeNote(NotesModel note) {
    _items.remove(note);
    notifyListeners();
  }

  NotesModel? getNote(int index) => _items[index];
}
