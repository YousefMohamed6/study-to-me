import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studytome/core/helper_widgets/custom_alart_dialog.dart';
import 'package:studytome/features/book/data/model/book_model.dart';
import 'package:studytome/features/image/data/model/image_model.dart';
import 'package:studytome/features/note/data/model/note_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(Book());
  bool isTapSearch = false;
  int _currentIndex = 0;
  get currentIndex => _currentIndex;
  bool isArabic = true;
  String language = 'ar';
  int color = Colors.blue.value; //Default Color
  List<int> colors = [
    Colors.lightGreen.value,
    Colors.lightBlue.value,
    Colors.orange.shade300.value,
    Colors.red.shade300.value,
    Colors.grey.value,
  ];
  void changeLanguage() {
    isArabic = !isArabic;
    language = isArabic ? 'ar' : 'en';
    emit(ContactUs());
  }

  void changeIndex(int select) {
    _currentIndex = select;
    if (select == 0) {
      emit(Book());
    } else if (select == 1) {
      emit(Images());
    } else if (select == 2) {
      emit(Note());
    } else if (select == 3) {
      emit(ToDo());
    } else if (select == 4) {
      emit(WebView());
    } else {
      emit(ContactUs());
    }
  }

  void showSearchView() {
    isTapSearch = true;
    changeIndex(_currentIndex);
  }

  void showInitialAppBar() {
    isTapSearch = false;
    changeIndex(_currentIndex);
  }

  showAlertDialog({
    required BuildContext context,
    required Function() onPressOk,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(onPressOk: onPressOk);
      },
    );
  }

  void showBottomSheet({required Widget builder, required context}) async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) => builder);
  }

  void showImageView({required ImageModel image}) {
    emit(ShowImage(image: image));
  }

  void showBookView({required BookModel book}) {
    emit(ShowBook(book: book));
  }

  void showNoteView({required NoteModel note}) {
    emit(ShowNote(note: note));
  }
}
