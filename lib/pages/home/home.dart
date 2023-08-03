// ignore_for_file: prefer_const_constructors

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/cards/card_home.dart';
import '../../utils/strings.dart';
import '../task/list_task.dart';
import '../task/new_task.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  Color selectedColor;

  HomePage({super.key, required this.selectedColor});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((value) {
      if (!value) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(allowNotifications),
            content: const Text(allowMessageNotification),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  dontAllow,
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () => AwesomeNotifications()
                    .requestPermissionToSendNotifications()
                    .then((value) => Navigator.pop(context)),
                child: Text(
                  allow,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
    _loadColor();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(appbarHome),
        ),
      ),
      body: Column(
        children: [
          CardHome(
            title: labelCardHomeTitle1,
            description: labelCardHomedescription1,
            onTap: () => goNewList(),
          ),
          const SizedBox(height: 25),
          CardHome(
            title: labelCardHomeTitle2,
            description: labelCardHomedescription2,
            onTap: () => goTaskList(),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                _loadColor();
                              },
                              child: Text("Feito"))
                        ],
                        title: Text("Escolha uma cor"),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                              pickerColor: widget.selectedColor,
                              onColorChanged: (Color color) {
                                _saveColor(color);
                              }),
                        ),
                      );
                    });
              },
              child: Text("Change color")),
        ],
      ),
    );
  }

  _saveColor(Color pickedColor) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt('color', pickedColor.value);
    _loadColor();
  }

  Future<void> _loadColor() async {
    var prefs = await SharedPreferences.getInstance();
    var colorValue = prefs.getInt('color');

    if (colorValue != null) {
      setState(() {
        widget.selectedColor = Color(colorValue);
      });
    } else {
      setState(() {
        widget.selectedColor = Colors.red;
      });
    }
  }

  goNewList() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NewTaskPage()));
  }

  goTaskList() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const TaskListPage()));
  }
}
