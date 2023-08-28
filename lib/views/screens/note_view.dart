import 'package:flutter/material.dart';
import 'package:noteapp/views/widgets/custom_appbar.dart';
import 'package:noteapp/views/widgets/note_list_view.dart';
import 'package:noteapp/views/widgets/vertical_sizebox.dart';

class NoteView extends StatelessWidget {
  static String id = 'NoteView';
  const NoteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: 'Notes',
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          const VerticalSizedBox(8),
          const ListViewNotes(),
        ],
      ),
    );
  }
}
