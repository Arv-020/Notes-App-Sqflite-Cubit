import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes/controller/app_database_provider.dart';

Color get randomColor =>
    Colors.primaries[Random().nextInt(Colors.primaries.length - 1)].shade300;
Color colorOfNote = randomColor;

class NotesModel {
  NotesModel({
    required this.time,
    required this.title,
    required this.desc,
    required this.id,
  }) : noteColor = randomColor;
  final String title;
  final String desc;
  final String time;
  final int id;

  final Color noteColor;

  @override
  operator ==(covariant NotesModel other) {
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  factory NotesModel.fromMap(Map<String, dynamic> data) {
    return NotesModel(
        id: data[AppDataBaseProvider.TABLE_ID],
        time: data[AppDataBaseProvider.TABLE_DATE],
        title: data[AppDataBaseProvider.TABLE_TITLE],
        desc: data[AppDataBaseProvider.TABLE_DESC]);
  }

  Map<String, dynamic> toMap() {
    return {
      AppDataBaseProvider.TABLE_DATE: time,
      AppDataBaseProvider.TABLE_TITLE: title,
      AppDataBaseProvider.TABLE_DESC: desc
    };
  }
}
