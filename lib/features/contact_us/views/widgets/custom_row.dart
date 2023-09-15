import 'package:flutter/material.dart';
import 'package:studytome/core/helper_widgets/custom_text.dart';
import 'package:studytome/core/helper_widgets/custom_text_button.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.text,
    required this.textButton,
    required this.onPressed,
    this.mainAxisAlignment,
  });
  final String text;
  final String textButton;
  final VoidCallback onPressed;
  final MainAxisAlignment? mainAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment!,
      children: [
        CustomText(
          text: text,
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        CustomTextButton(
          text: textButton,
          fontWeight: FontWeight.bold,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
