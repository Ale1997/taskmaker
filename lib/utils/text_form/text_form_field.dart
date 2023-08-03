import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFormFieldCustom extends StatelessWidget {
  var controller = TextEditingController();
  var task = "";

  TextFormFieldCustom({
    super.key,
    required this.controller,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        cursorColor: Colors.white,
        maxLines: 2,
        controller: controller,
        keyboardType: TextInputType.text,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
            border: InputBorder.none,
            errorStyle: TextStyle(color: Theme.of(context).primaryColor),
            filled: true,
            fillColor: Theme.of(context).primaryColor,
            labelText: task,
            labelStyle: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
