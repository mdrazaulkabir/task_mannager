import 'package:flutter/material.dart';

import '../widgets/task_card.dart';
class CompleteTaskListScreen extends StatefulWidget {
  const CompleteTaskListScreen({super.key});
  static const String name='completeTaskListScreen';
  @override
  State<CompleteTaskListScreen> createState() => _CompleteTaskListScreenState();
}

class _CompleteTaskListScreenState extends State<CompleteTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: TMAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: ListView.builder(itemBuilder: (context,index){
          //return TaskCard(taskType: TaskType.complete);
        }),
      ),
    );
  }
}
