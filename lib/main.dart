import 'package:flutter/material.dart';
import 'package:trago/Map.dart';
import 'package:trago/Profile.dart';
import 'package:trago/login.dart';
import 'package:trago/packages.dart';
import 'package:trago/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trago',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
