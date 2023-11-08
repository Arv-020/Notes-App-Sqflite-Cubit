import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/notes_model.dart';

class AppDataBaseProvider extends ChangeNotifier {
  // named constructor
  AppDataBaseProvider._instance();
  static final AppDataBaseProvider _noteInstance =
      AppDataBaseProvider._instance();
  factory AppDataBaseProvider() => _noteInstance;

  static const String TABLE_NAME = "notes";
  static const String TABLE_ID = "id";
  static const String TABLE_TITLE = "title";
  static const String TABLE_DESC = "desc";
  static const String TABLE_DATE = "date";
  static const String TABLE_COLOR = "color";

  //list of notes
  List<NotesModel> _items = [];
  UnmodifiableListView<NotesModel> get items => UnmodifiableListView(_items);

  //formatted date
  //  String  date() {
  //   return "hello";
  //  }

  //number of notes
  int get length => items.length;

//Database
  Database? db;

//get DataBase

  Future<Database> getDb() async {
    if (db != null) {
      return db!;
    } else {
      db = await initDb();
      return db!;
    }
  }

// DataBase initialization
  Future<Database> initDb() async {
    var getApplicationDirectory = await getApplicationDocumentsDirectory();

    var dbPath = join(getApplicationDirectory.path, "notesDb");

    return openDatabase(dbPath, version: 1, onCreate: (db, _) {
      db.execute(
          "Create Table $TABLE_NAME ($TABLE_ID integer primary key autoincrement, $TABLE_TITLE text not null,$TABLE_DESC text,$TABLE_DATE text not null)");
    });
  }

//Database Operation:

//add note
  void addNote(NotesModel note) async {
    final db = await getDb();
    db.insert(
      TABLE_NAME,
      note.toMap(),
    );

    getAllNotes();
  }

  void removeNote(NotesModel note) async {
    var db = await getDb();
    db.delete(TABLE_NAME, where: "$TABLE_ID = ?", whereArgs: [note.id]);
    getAllNotes();
  }

  void updateNote(NotesModel note) async {
    var db = await getDb();
    db.update(TABLE_NAME, note.toMap(),
        where: "$TABLE_ID = ?", whereArgs: [note.id]);
    getAllNotes();
  }

  void getAllNotes() async {
    var db = await getDb();

    List select = await db.query(TABLE_NAME);
    List<NotesModel> notes = [];
    for (final element in select) {
      notes.add(NotesModel.fromMap(element));
    }
    _items = notes;

    notifyListeners();
  }

  void foundNotes(String title, BuildContext context) {
    if (title.isEmpty) {
      getAllNotes();
    } else {
      _items =
          _items.where((element) => element.title.contains(title)).toList();
    }
    notifyListeners();
  }
  //getnote by index
  // NotesModel? getNote(int index) => _items[index];
}
