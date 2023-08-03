import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/cards/card_list.dart';
import '../../utils/strings.dart';
import '../model/task.dart';
import 'new_task.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appBarListTask),
      ),
      body: tasks.isEmpty
          ? Column(
              children: [
                const SizedBox(height: 45),
                const Text(
                  textAlign: TextAlign.center,
                  notFound,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 45),
                Lottie.asset("assets/json/animation_lkblhwdf.json",
                    height: 200),
                const SizedBox(height: 45),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewTaskPage())),
                  child: const Text(labelButton,
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final item = tasks[index];
                return CardList(
                    task: item,
                    onTap: () => _remove(index),
                    dayOfWeekText: _getDayOfWeekText(item.dayOfWeek),
                    showDayOfWeek: item.dayOfWeek != null);
              }),
    );
  }

  void _save() async {
    var prefs = await SharedPreferences.getInstance();
    List tasksJson = tasks.map((e) => e.toJson()).toList();
    String tasksJsonString = jsonEncode(tasksJson);
    await prefs.setString('data', tasksJsonString);
  }

  Future _load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Task> result = decoded.map((e) => Task.fromJson(e)).toList();
      setState(() {
        tasks = result;
      });
    }
  }

  void _remove(int index) {
    setState(() {
      tasks.removeAt(index);
      _save();
      _load();
    });
  }

  String _getDayOfWeekText(int? dayOfWeek) {
    List<String> weekdays = [
      'Segunda',
      'Terça',
      'Quarta',
      'Quinta',
      'Sexta',
      'Sábado',
      'Domingo'
    ];
    if (dayOfWeek != null && dayOfWeek >= 1 && dayOfWeek <= 7) {
      return weekdays[dayOfWeek - 1];
    } else {
      return '';
    }
  }
}
