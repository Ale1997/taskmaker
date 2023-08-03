import 'package:flutter/material.dart';

import '../text_form/text_form_field.dart';
// ignore: must_be_immutable
class CardTask extends StatelessWidget {
  TextFormFieldCustom textFormFieldCustom;
  CardTask({super.key, required this.textFormFieldCustom});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Theme.of(context).primaryColor,
        child: textFormFieldCustom,
      ),
    );
  }
}
