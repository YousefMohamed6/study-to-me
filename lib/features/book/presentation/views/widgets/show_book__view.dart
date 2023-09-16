import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';
import 'package:studytome/core/helper_widgets/custom_icon_button.dart';
import 'package:studytome/core/helper_widgets/custom_text.dart';
import 'package:studytome/core/utils/show_message.dart';
import 'package:studytome/features/book/data/model/book_model.dart';
import 'package:studytome/features/home/data/cubit/home_cubit.dart';

class ShowBookView extends StatefulWidget {
  final BookModel book;

  const ShowBookView({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  ShowBookViewState createState() => ShowBookViewState();
}

class ShowBookViewState extends State<ShowBookView>
    with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonToBookView(),
        title: CustomText(text: widget.book.name),
        actions: [
          ShareFileButton(filePath: widget.book.path),
        ],
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PDFView(
            filePath: widget.book.path,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: true,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation: false,
            onRender: (pages) {
              setState(() {
                pages = pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              ShowMessage.show(context, msg: errorMessage);
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              ShowMessage.show(context, msg: errorMessage);
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onPageChanged: (int? page, int? total) {
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: CustomText(
                    text: errorMessage,
                  ),
                ),
        ],
      ),
    );
  }
}

class ShareFileButton extends StatelessWidget {
  const ShareFileButton({super.key, required this.filePath});
  final String filePath;
  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: const Icon(Icons.share),
      onPressed: () async {
        await Share.shareXFiles(
          [XFile(filePath)],
        );
      },
    );
  }
}

class BackButtonToBookView extends StatelessWidget {
  const BackButtonToBookView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackButton(
      color: Colors.white,
      onPressed: () {
        BlocProvider.of<HomeCubit>(context).changeIndex(0);
      },
    );
  }
}
