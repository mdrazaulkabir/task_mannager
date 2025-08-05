import 'package:flutter/material.dart';
import 'package:task_mannager/data/model/task_model.dart';
import 'package:task_mannager/data/service/network_caller.dart';
import 'package:task_mannager/ui/widgets/center_circular_Progress_indicator.dart';
import 'package:task_mannager/ui/widgets/show_snack_bar_massanger.dart';

import '../../data/urls.dart';

enum TaskType { tNew, progress, complete, canceled }

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskType,
    required this.taskModel,
    required this.onStatusUpdate,
  });

  final TaskType taskType;
  final TaskModel taskModel;
  final VoidCallback onStatusUpdate;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  bool _updateTaskStatusInProgress=false;
  bool _deleteTaskInProgress=false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title: ${widget.taskModel.title}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "Description: ${widget.taskModel.description}",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Date: ${widget.taskModel.createDate}",
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
                    style: const TextStyle(color: Colors.white),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: _getTaskChipColor(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                const Spacer(),
                Visibility(
                  visible: _updateTaskStatusInProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: IconButton(
                      onPressed: () {
                        _showEditTaskStatusDialog();
                      },
                      icon: const Icon(Icons.edit)),
                ),
                const SizedBox(
                  width: 3,
                ),
                Visibility(
                  visible: _deleteTaskInProgress==false,
                  replacement: CenterCircularProgressIndicator(),
                  child: IconButton(
                      onPressed: () {
                        _showDeleteConfirmAlertDialog();
                      },
                      icon: const Icon(Icons.delete)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getTaskChipColor() {
    if (widget.taskType == TaskType.tNew) {
      return Colors.blue;
    } else if (widget.taskType == TaskType.progress) {
      return Colors.green;
    } else if (widget.taskType == TaskType.complete) {
      return Colors.yellowAccent;
    } else {
      return Colors.red;
    }
  }

  String _getTypeTaskName(){
    if (widget.taskType == TaskType.tNew) {
      return "New";
    } else if (widget.taskType == TaskType.progress) {
      return "Progress";
    } else if (widget.taskType == TaskType.complete) {
      return "Completed";
    } else {
      return "Canceled";
    }
  }

  void _showEditTaskStatusDialog(){
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        title: const Text("Change Status"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("New"),
              trailing: _getTaskStatusTrailing(TaskType.tNew),
              onTap: (){
                onTapTaskStatus(TaskType.tNew,'New');
              },
            ),
            ListTile(
              title: const Text("In progress"),
              trailing: _getTaskStatusTrailing(TaskType.progress),
              onTap: (){
                onTapTaskStatus(TaskType.progress,'Progress');
              },
            ),
            ListTile(
              title: const Text("Complete"),
              trailing: _getTaskStatusTrailing(TaskType.complete),
              onTap: (){
                onTapTaskStatus(TaskType.complete,'Complete');
              },
            ),
            ListTile(
              title: const Text("Cancel"),
              trailing: _getTaskStatusTrailing(TaskType.canceled),
              onTap: (){
                onTapTaskStatus(TaskType.canceled,'Canceled');
              },
            ),
          ],
        ),
      );
    });
  }


  Widget? _getTaskStatusTrailing(TaskType type){
    return widget.taskType ==type ? const Icon(Icons.check):null;
  }

  void onTapTaskStatus(TaskType type,String statusText){
    if(widget.taskType==type){
      return;
    }
    _updateTaskStatus(statusText);
  }


  Future<void>_updateTaskStatus(String status)async{
    _updateTaskStatusInProgress=true;
    if(mounted){
      setState(() { });
    }
    NetworkResponse response= await NetworkCaller.getRequest(url: Urls.updateTaskStatusUrl(widget.taskModel.id, status));
    _updateTaskStatusInProgress=false;
    if(mounted){
      setState(() {});
    }
    if(response.isSuccess){
      widget.onStatusUpdate();
    }
    else{
      if(mounted){
        ShowSnackBarMessage(context, response.errorMessage!);
      }
    }
  }
  
  
  Future<void>_showDeleteConfirmAlertDialog()async{
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        title: const Text("Delete Task"),
        content: const Text("Are you sure you want to delete this task!"),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text("Cancel"),),
          TextButton(onPressed: (){
            Navigator.pop(context);
            _DeleteTask();
          }, child: const Text("Confirm"),)
        ],
      );
    });
  }
  Future<void>_DeleteTask()async{
    _deleteTaskInProgress=true;
    if(mounted){
      setState(() {});
    }
    NetworkResponse response=await NetworkCaller.getRequest(url: Urls.deleteUrl(widget.taskModel.id));
    _deleteTaskInProgress=false;
    if(mounted){
      setState(() {});
    }
    if(response.isSuccess){
      ShowSnackBarMessage(context, "Task Deleted Successfully!");
      widget.onStatusUpdate();
    }
    else{
      ShowSnackBarMessage(context, response.errorMessage?? 'Deleted falid!');
    }
  }


  
}
