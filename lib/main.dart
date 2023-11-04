import 'package:flutter/material.dart';
import 'package:notes/home_page.dart';
// import 'package:notes/list_tile.dart';
import 'package:notes/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
