import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class NotesModel {
  NotesModel(
      {required this.id,
      required this.time,
      required this.title,
      required this.desc});
  String title;
  String desc;
  String time;
  int id;
}
