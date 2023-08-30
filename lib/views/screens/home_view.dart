import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/cubits/navigatorbar/navigatore_cubit.dart';
import 'package:noteapp/cubits/note/note_cubit.dart';
import 'package:noteapp/cubits/todo/todo_cubit.dart';
import 'package:noteapp/views/screens/books_view.dart';
import 'package:noteapp/views/screens/file_view.dart';
import 'package:noteapp/views/screens/note_view.dart';
import 'package:noteapp/views/screens/todo_view.dart';
import 'package:noteapp/views/screens/webview.dart';
import 'package:noteapp/views/widgets/navigationbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBarCubit, NavigatoreBarState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: state is Youtube
              ? null
              : FloatingActionButton(
                  backgroundColor: Colors.white.withOpacity(0.25),
                  child: const Icon(
                    Icons.add,
                    size: 24,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (state is File) {
                    } else if (state is Note) {
                      BlocProvider.of<NoteCubit>(context)
                          .showAddNoteSheet(context);
                    } else if (state is ToDo) {
                      BlocProvider.of<ToDoCubit>(context)
                          .showBottomSheet(context);
                    } else {}
                  },
                ),
          bottomNavigationBar: CustombottomBar(
            currentIndex:
                BlocProvider.of<NavigationBarCubit>(context).currentIndex,
          ),
          body: BlocBuilder<NavigationBarCubit, NavigatoreBarState>(
            builder: (context, state) {
              if (state is File) {
                return const FileView();
              } else if (state is Note) {
                BlocProvider.of<NoteCubit>(context).fetshNotes();
                return const NoteView();
              } else if (state is ToDo) {
                BlocProvider.of<ToDoCubit>(context).fetchTasks();
                return const ToDoView();
              } else if (state is Book) {
                return const BookView();
              } else {
                return const WebView(url: 'https://www.youtube.com/');
              }
            },
          ),
        );
      },
    );
  }
}
