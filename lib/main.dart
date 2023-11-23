import 'package:flutter/material.dart';
import 'package:notes/controller/app_controllers.dart';
import 'package:notes/screens/home_page.dart';

import 'package:provider/provider.dart';

import 'controller/app_db_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppDataBaseProvider(),
      child: ChangeNotifierProvider(
          create: (_) => AppControllerProvider(),
          child: const MaterialApp(
              debugShowCheckedModeBanner: false, home: HomePage())),
    );
  }
}
