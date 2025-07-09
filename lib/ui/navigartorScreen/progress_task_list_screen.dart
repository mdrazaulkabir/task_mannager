import 'package:flutter/material.dart';

import '../widgets/task_card.dart';
class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});
  static const String name='progressTaskListScreen';
  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: TMAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: ListView.builder(itemBuilder: (context,index){
          return TaskCard(taskType: TaskType.progress);
        }),
      ),

    );
  }
}
