import 'package:flutter/material.dart';
import 'package:studytome/core/helper_widgets/custom_form_field.dart';
import 'package:studytome/generated/l10n.dart';

class TitleFormFeild extends StatelessWidget {
  const TitleFormFeild({super.key, required this.titleCtrl});
  final TextEditingController titleCtrl;
  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      controller: titleCtrl,
      lablelText: S.of(context).title,
    );
  }
}
