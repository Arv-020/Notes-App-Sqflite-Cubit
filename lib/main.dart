import 'package:flutter/material.dart';
import 'package:notes/controller/app_controllers.dart';
import 'package:notes/screens/home_page.dart';

import 'package:provider/provider.dart';

import 'controller/app_database_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AppDataBaseProvider>(
              create: (_) => AppDataBaseProvider()),
          ChangeNotifierProvider<AppControllerProvider>(
              create: (_) => AppControllerProvider()),
        ],
        child: const MaterialApp(
            debugShowCheckedModeBanner: false, home: HomePage()));
  }
}
