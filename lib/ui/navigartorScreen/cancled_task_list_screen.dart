import 'package:flutter/material.dart';
import 'package:task_mannager/ui/widgets/task_card.dart';
class CancledTaskListScreen extends StatefulWidget {
  const CancledTaskListScreen({super.key});
  static const String name='canceledTaskListScreen';
  @override
  State<CancledTaskListScreen> createState() => _CancledTaskListScreenState();
}

class _CancledTaskListScreenState extends State<CancledTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: TMAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: ListView.builder(itemBuilder: (context,index){
          //return TaskCard(taskType: TaskType.canceled);
        }),
      ),
    );
  }
}
