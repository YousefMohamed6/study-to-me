import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:noteapp/const/text.dart';
import 'package:noteapp/ui/note/model/note_model.dart';
import 'package:noteapp/views/widgets/custom_text.dart';
import 'package:noteapp/views/widgets/custom_text_button.dart';
import 'package:noteapp/ui/note/note_sheet.dart';
part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());
  List<NoteModel> notes = [];
  var contentCtrl = TextEditingController();
  var titleCtrl = TextEditingController();
  void showAddNoteSheet(context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => AddNoteSheet(
        titleCtrl: titleCtrl,
        contentCtrl: contentCtrl,
        formkey: GlobalKey<FormState>(),
      ),
    );
  }

  void showEditNoteSheet(context, Widget builder) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) => builder);
  }

  void editNote(NoteModel note) {
    addNote(
      NoteModel(
          color: note.color,
          content: contentCtrl.text,
          date: note.date,
          title: titleCtrl.text),
    );
    emit(EditNoteSuccess());
    deleteNote(note);
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

  void deleteNote(NoteModel note) {
    note.delete();
    fetshNotes();
  }

  showAlertDialog(BuildContext context, NoteModel note) {
    Widget cancelButton = CustomTextButton(
      text: 'Cancel',
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = CustomTextButton(
      text: "Ok",
      onPressed: () {
        deleteNote(note);
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: const CustomText(text: "Alert"),
      content: const CustomText(text: "Would you like to delete it"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}