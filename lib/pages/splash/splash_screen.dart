// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/strings.dart';
import '../home/home.dart';

class SplashScreen extends StatefulWidget {
  Color _selectedColor = Colors.red;
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // loadSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Lottie.asset("assets/json/tasklist.json"),
    );
  }

  // Future<void> loadSplash() async {
  //   final context = this.context;
  //   await Future.delayed(
  //     const Duration(seconds: 5),
  //   );
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => HomePage(),
  //     ),
  //   );
  // }
}
