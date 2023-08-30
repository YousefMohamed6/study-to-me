part of 'note_cubit.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class AddColor extends NoteState {}

class AddNoteSuccess extends NoteState {}

class AddNoteFailure extends NoteState {
  final String errMessage;
  AddNoteFailure(this.errMessage);
}

class EditNoteSuccess extends NoteState {}

class EditNoteFailure extends NoteState {
  final String errMessage;
  EditNoteFailure(this.errMessage);
}