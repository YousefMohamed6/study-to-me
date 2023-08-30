import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:noteapp/const/text.dart';
import 'package:noteapp/screens/note/model/note_model.dart';
part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());
  List<NoteModel> notes = [];
  int color = Colors.blue.value;

  var titleCtrl = TextEditingController();
  var contentCtrl = TextEditingController();

  void addColor() {
    emit(AddColor());
  }

  void editNote(NoteModel note) {
    note.content = contentCtrl.text;
    note.title = titleCtrl.text;
    note.save();
    emit(EditNoteSuccess());
    fetshNotes();
  }

  void addNote(NoteModel note) async {
    try {
      var noteBox = Hive.box<NoteModel>(kNoteBox);
      await noteBox.add(note);
      fetshNotes();
      emit(AddNoteSuccess());
      emit(NoteInitial());
    } on Exception {
      emit(AddNoteFailure('Failed'));
      emit(NoteInitial());
    }
  }

  void fetshNotes() async {
    notes.clear();
    var noteBox = Hive.box<NoteModel>(kNoteBox);
    notes.addAll(noteBox.values.toList());
    emit(NoteInitial());
  }
}
