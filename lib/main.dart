import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmaker/pages/home/home.dart';
import 'package:taskmaker/utils/strings.dart';

void main() {
  AwesomeNotifications().initialize(
    'resource://drawable/warning',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic notifications',
        defaultColor: primaryColor,
        ledColor: primaryColor,
        // soundSource: "resource://drawable/alarm_sound",
        // soundSource: "assets/sound/alarm_sound",
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
    ],
  );
  runApp(const MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MaterialColor appPrimaryColor = Colors.red;
  @override
  void initState() {
    _loadColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: appPrimaryColor,
      ),
      home: HomePage(selectedColor: appPrimaryColor),
    );
  }

  Future<void> _loadColor() async {
    var prefs = await SharedPreferences.getInstance();
    var colorValue = prefs.getInt('color');
    if (colorValue != null) {
      setState(() {
        appPrimaryColor = _createMaterialColor(Color(colorValue));
      });
    } else {
      setState(() {
        appPrimaryColor = _createMaterialColor(Colors.red);
      });
    }
  }

  MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }
}
