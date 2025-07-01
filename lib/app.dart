import 'package:flutter/material.dart';
import 'package:task_mannager/ui/screeen/splash_screen.dart';
class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: splashScreen(),
    );
  }
}
