import 'package:flutter/material.dart';

enum TaskType { tnew, progress, complete, canceled }

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.taskType,
  });

  final TaskType taskType;

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
              "Title",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "Description",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Date",
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
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
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
}
