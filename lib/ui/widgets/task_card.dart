import 'dart:js';

import 'package:flutter/material.dart';
import 'package:task_mannager/data/model/task_model.dart';

enum TaskType { tnew, progress, complete, canceled }

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.taskType,
    required this.taskModel,
  });

  final TaskType taskType;
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.grey[300],
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title${taskModel.title}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "Description${taskModel.description}",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Date${taskModel.createDate}",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Chip(
                  label: Text(
                    _getTypeTaskName(),
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: _getTaskChipColor(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                const SizedBox(
                  width: 3,
                ),
                IconButton(onPressed: () {
                  _showEditTaskStatusDialog();
                }, icon: Icon(Icons.delete)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getTaskChipColor() {
    if (taskType == TaskType.tnew) {
      return Colors.blue;
    } else if (taskType == TaskType.progress) {
      return Colors.green;
    } else if (taskType == TaskType.complete) {
      return Colors.yellowAccent;
    } else {
      return Colors.red;
    }
  }
  String _getTypeTaskName(){
    if (taskType == TaskType.tnew) {
      return "New";
    } else if (taskType == TaskType.progress) {
      return "Progress";
    } else if (taskType == TaskType.complete) {
      return "Completed";
    } else {
      return "Canceled";
    }
  }
  void _showEditTaskStatusDialog(){
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        title: Text("change Status"),
        content: Column(
          children: [
            ListTile(
              title: Text("New"),
              trailing: _getTaskStatusTrailing(TaskType.tnew),

            ),
            ListTile(
              title: Text("In progress"),
              trailing: _getTaskStatusTrailing(TaskType.progress),

            ),
            ListTile(
              title: Text("Complete"),
              trailing: _getTaskStatusTrailing(TaskType.complete),

            ),
            ListTile(
              title: Text("Cancel"),
              trailing: _getTaskStatusTrailing(TaskType.canceled),

            ),
          ],
        ),
      );
    });
  }
  Widget? _getTaskStatusTrailing(TaskType type){
    return widget.taskType ==type ? Icon(Icons.check):null;
  }


}
