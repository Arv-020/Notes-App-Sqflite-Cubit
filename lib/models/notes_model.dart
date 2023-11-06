import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class NotesModel {
  NotesModel(
      {required this.time,
      required this.title,
      required this.desc,
      this.visible = false})
      : id = const Uuid().v4(),
        noteColor = Colors
            .primaries[Random().nextInt(Colors.primaries.length - 1)].shade300;
  final String title;
  final String desc;
  final String time;
  final String id;
  final bool visible;
  final Color noteColor;

  @override
  operator ==(covariant NotesModel other) {
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
