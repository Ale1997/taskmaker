// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/cards/card_task.dart';
import '../../utils/notifications.dart';
import '../../utils/strings.dart';
import '../../utils/text_form/text_form_clock.dart';
import '../../utils/text_form/text_form_field.dart';
import '../model/task.dart';

class NewTaskPage extends StatefulWidget {
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;

  const NewTaskPage({Key? key, this.selectedDate, this.selectedTime})
      : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  List<Task> _tasks = [];

  TimeOfDay? _selectedTime;
  int? _selectedDay;
  final _controllerTitle = TextEditingController();
  final _controllerDescription = TextEditingController();
  final _controllerTimer = TextEditingController();
  Notifications notifications = Notifications();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Center(
          //   child: Text(
          //     appBarNewTask,
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //         color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          //   ),
          // ),
          ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.asset("assets/json/animation_newtask.json",
                height: 300, alignment: Alignment.topCenter),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CardTask(
                    textFormFieldCustom: TextFormFieldCustom(
                      controller: _controllerTitle,
                      task: textFormTitle,
                    ),
                  ),
                  CardTask(
                    textFormFieldCustom: TextFormFieldCustom(
                        controller: _controllerDescription,
                        task: textFormDescription),
                  ),
                  SizedBox(height: 10),
                  TextFormClock(
                      controller: _controllerTimer,
                      function: () => _selectTime()),
                  SizedBox(height: 10),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () {
                      formKey.currentState?.validate();
                      _add();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: const Text(
                        labelButton,
                        style: TextStyle(color: Colors.white),
                      ),
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

  _add() async {
    var prefs = await SharedPreferences.getInstance();
    if (_controllerTitle.text.isEmpty) {
      return emptyField;
    }

    setState(() {
      List<dynamic>? existingTasksJson =
          jsonDecode(prefs.getString('data') ?? '[]');
      List<Task> existingTasks =
          existingTasksJson?.map((e) => Task.fromJson(e)).toList() ?? [];

      existingTasks.add(Task(
        title: _controllerTitle.text,
        description: _controllerDescription.text,
        time: _selectedTime != null
            ? DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, _selectedTime!.hour, _selectedTime!.minute)
            : null,
        dayOfWeek: _selectedDay,
      ));

      _tasks = existingTasks;
      _scheduleNotification();
      _controllerTitle.clear();
      _controllerDescription.clear();
      _selectedTime = null;
      _selectedDay = null;
      _save();
      _showToast();

      Navigator.pop(context);
    });
  }

  void _save() async {
    var prefs = await SharedPreferences.getInstance();
    List taskJson = _tasks.map((e) => e.toJson()).toList();
    String tasksJsonString = jsonEncode(taskJson);
    await prefs.setString('data', tasksJsonString);
  }

  void _showToast() {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content: Text(
          toastMessage,
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Future<void> _selectTime() async {
    final timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timeOfDay != null) {
      List<String> weekdays = [
        'Segunda',
        'Terça',
        'Quarta',
        'Quinta',
        'Sexta',
        'Sábado',
        'Domingo'
      ];

      // ignore: use_build_context_synchronously
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                rememberWhen,
                textAlign: TextAlign.center,
              ),
              content: Wrap(
                alignment: WrapAlignment.center,
                spacing: 3,
                children: [
                  for (int i = 0; i < weekdays.length; i++)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedDay = i + 1;
                        });
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Theme.of(context).primaryColor)),
                      child: Text(weekdays[i]),
                    )
                ],
              ),
            );
          });
      if (_selectedDay != null) {
        setState(() {
          _selectedTime = timeOfDay;
        });
      }
    }
  }

  void _scheduleNotification() async {
    if (_selectedDay != null && _selectedTime != null) {
      final now = DateTime.now();
      final selectedDateTime = DateTime(
          now.year,
          now.month,
          now.day + (_selectedDay! - now.weekday),
          _selectedTime!.hour,
          _selectedTime!.minute);

      notifications.createNotification(
        context,
        _controllerTitle.text,
        _controllerDescription.text,
        NotificationCalendar.fromDate(
          date: selectedDateTime,
          repeats: true,
        ),
      );
    } else {
      throw ("Erro ao criar notificação");
    }
  }
}
