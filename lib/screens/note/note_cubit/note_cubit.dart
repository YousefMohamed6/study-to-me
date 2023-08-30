import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:noteapp/const/text.dart';
import 'package:noteapp/helper_widgets/custom_text.dart';
import 'package:noteapp/screens/note/model/note_model.dart';
import 'package:noteapp/helper/helper_widgets/custom_text_button.dart';
part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());
  List<NoteModel> notes = [];
  int color = Colors.blue.value;
  List<int> colors = [
    Colors.blue.value,
    Colors.lightGreen.value,
    Colors.lightBlue.value,
    Colors.orange.shade300.value,
  ];
  var titleCtrl = TextEditingController();
  var contentCtrl = TextEditingController();

  void addColor() {
    emit(AddColor());
  }

  Widget listColor({required onPressed}) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: colors.length,
      itemBuilder: (context, index) => ElevatedButton(
        onPressed: () {
          color = colors[index];
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
          backgroundColor: Color(colors[index]),
        ),
        child: const SizedBox(),
      ),
    );
  }

  void showBottomSheet(context, {required Widget builder}) async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) => builder);
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
