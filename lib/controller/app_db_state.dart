import 'package:notes/models/notes_model.dart';

abstract class NotesState {}

class LoadingState extends NotesState {}

class LoadedState extends NotesState {
  List<NotesModel> notes;
  LoadedState({required this.notes});
}
