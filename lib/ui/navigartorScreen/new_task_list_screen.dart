import 'package:flutter/material.dart';
import 'package:task_mannager/ui/screeen/update_profile_screen.dart';

import '../widgets/default_task_count_summary_card.dart';
import '../widgets/task_card.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});
  static const String name='newTaskListScreen';

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 110,
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 6),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return DefaultTaskCountSummaryCard(
                    title: "cancled",
                    count: 19,
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      width: 35,
                    ),
                itemCount: 4),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskType: TaskType.tnew,
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:_onTapFloatingActionButton,
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }
  void _onTapFloatingActionButton(){
    Navigator.pushNamedAndRemoveUntil(context, UpdateProfileScreen.name, (route) => false);
  }
}
