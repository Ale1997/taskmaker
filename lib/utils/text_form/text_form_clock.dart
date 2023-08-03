import 'package:flutter/material.dart';
import '../strings.dart';

// ignore: must_be_immutable
class TextFormClock extends StatelessWidget {
  var controller = TextEditingController();
  Function() function;

  TextFormClock({super.key, required this.controller, required this.function});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: function,
        decoration: InputDecoration(
            hintText: setTime,
            errorStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
            border: InputBorder.none,
            hintStyle:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
            icon: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                child: Icon(
                  Icons.lock_clock,
                  color: Colors.white,
                ),
              ),
            )),
        validator: (value) {
          if (value!.isEmpty) {
            return pleaseSetTime;
          }
          return null;
        },
      ),
    );
  }
}
