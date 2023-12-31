import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studytome/core/utils/show_message.dart';
import 'package:studytome/features/note/data/model/note_model.dart';
import 'package:studytome/features/note/data/note_cubit/note_cubit.dart';
import 'package:studytome/features/note/presentation/views/widgets/note_list_view_body.dart';
import 'package:studytome/generated/l10n.dart';

class NoteListView extends StatelessWidget {
  const NoteListView({super.key, required this.notesList});

  final List<NoteModel> notesList;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteState>(
      listener: (context, state) {
        if (state is NoteInitial) {
        } else if (state is AddNoteSuccess) {
          ShowMessage.show(context, msg: S.of(context).addSuccess);
          Navigator.pop(context);
        } else if (state is AddNoteFailure) {
          ShowMessage.show(context, msg: state.errMessage);
          Navigator.pop(context);
        } else if (state is EditNoteSuccess) {
          ShowMessage.show(context, msg: S.of(context).editSuccess);
          Navigator.pop(context);
        } else if (state is EditNoteFailure) {
          ShowMessage.show(context, msg: state.errMessage);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is NoteSearch) {
          return NoteListViewBody(
            notesList: state.notesList,
          );
        } else {
          return NoteListViewBody(
            notesList: notesList,
          );
        }
      },
    );
  }
}
