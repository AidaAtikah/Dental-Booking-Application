import 'dart:collection';
import 'package:dental_check/screen/LoginForm.dart';
import 'package:dental_check/widget/constant.dart';
import 'package:dental_check/screen/startup_screen.dart';
import 'package:flutter/material.dart';
import 'widget/constant.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: StartupScreen(),
    );
  }
}
