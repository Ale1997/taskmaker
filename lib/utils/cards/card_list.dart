import 'package:flutter/material.dart';

import '../../pages/model/task.dart';

// ignore: must_be_immutable
class CardList extends StatelessWidget {
  var task = Task();
  final VoidCallback onTap;
  final bool showDayOfWeek;
  final String dayOfWeekText;

  CardList(
      {super.key,
      required this.task,
      required this.onTap,
      required this.showDayOfWeek,
      required this.dayOfWeekText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                task.title!,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(task.description!,
                    style: const TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (showDayOfWeek)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        dayOfWeekText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  //Exibir se o horário estiver disponivel
                  if (task.time != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Horário: ${_formatTime(task.time!)}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  GestureDetector(
                    onTap: onTap,
                    // ignore: prefer_const_constructors
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return "$hour:$minute";
  }
}
