import 'package:flutter/material.dart';
import 'package:task_mannager/data/model/task_model.dart';
import 'package:task_mannager/data/service/network_caller.dart';
import 'package:task_mannager/ui/widgets/center_circular_Progress_indicator.dart';
import 'package:task_mannager/ui/widgets/show_snack_bar_massanger.dart';

import '../../data/urls.dart';

enum TaskType { tnew, progress, complete, canceled }

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskType,
    required this.taskModel,
  });

  final TaskType taskType;
  final TaskModel taskModel;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _updateTaskStatusInprogress=false;
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
              "Title${widget.taskModel.title}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "Description${widget.taskModel.description}",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Date${widget.taskModel.createDate}",
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
                Visibility(
                  visible: _updateTaskStatusInprogress==false,
                  replacement: CenterCircularProgressIndicator(),
                  child: IconButton(
                      onPressed: () {
                        _showEditTaskStatusDialog();
                      },
                      icon: Icon(Icons.edit)),
                ),
                const SizedBox(
                  width: 3,
                ), IconButton(onPressed: () {}, icon: Icon(Icons.delete)),

              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getTaskChipColor() {
    if (widget.taskType == TaskType.tnew) {
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
    if (widget.taskType == TaskType.tnew) {
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
        title: Text("change Status"),
        content: Column(
          children: [
            ListTile(
              title: Text("New"),
              trailing: _getTaskStatusTrailing(TaskType.tnew),
              onTap: (){
                if(widget.taskType==TaskType.tnew){
                  return;
                }
                _updateTaskStatus('New');
              },
            ),
            ListTile(
              title: Text("In progress"),
              trailing: _getTaskStatusTrailing(TaskType.progress),
              onTap: (){
                if(widget.taskType==TaskType.progress){
                  return;
                }
                _updateTaskStatus('Progress');
              },
            ),
            ListTile(
              title: Text("Complete"),
              trailing: _getTaskStatusTrailing(TaskType.complete),
              onTap: (){
                if(widget.taskType==TaskType.complete){
                  return;
                }
                _updateTaskStatus('Complete');
              },
            ),
            ListTile(
              title: Text("Cancel"),
              trailing: _getTaskStatusTrailing(TaskType.canceled),
              onTap: (){
                if(widget.taskType==TaskType.canceled){
                  return;
                }
                _updateTaskStatus('Canceled');
              },
            ),
          ],
        ),
      );
    });
  }


  Widget? _getTaskStatusTrailing(TaskType type){
    return widget.taskType ==type ? Icon(Icons.check):null;
  }


  Future<void>_updateTaskStatus(String status)async{
    _updateTaskStatusInprogress=true;
    if(mounted){
      setState(() { });
    }
    NetworkResponse response= await NetworkCaller.getRequest(url: Urls.updateTaskStatusUrl(widget.taskModel.id, status));
    _updateTaskStatusInprogress=false;
    if(mounted){
      setState(() {});
    }
    if(response.isSuccess){

    }
    else{
      if(mounted){
        ShowSnackBarMessage(context, response.errorMessage!);
      }
    }
  }

}
