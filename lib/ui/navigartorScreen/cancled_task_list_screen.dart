import 'package:flutter/material.dart';
import 'package:task_mannager/data/service/network_caller.dart';
import 'package:task_mannager/ui/widgets/show_snack_bar_massanger.dart';
import 'package:task_mannager/ui/widgets/task_card.dart';

import '../../data/model/task_model.dart';
import '../../data/urls.dart';
class CancledTaskListScreen extends StatefulWidget {
  const CancledTaskListScreen({super.key});
  static const String name='canceledTaskListScreen';
  @override
  State<CancledTaskListScreen> createState() => _CancledTaskListScreenState();
}

class _CancledTaskListScreenState extends State<CancledTaskListScreen> {
  bool _getCancelTaskInProgress=false;
  List<TaskModel>_cancelTaskList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCancelTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: TMAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Visibility(
          visible: _getCancelTaskInProgress==false,
          replacement: Center(child: CircularProgressIndicator(),),
          child: ListView.builder(itemBuilder: (context,index){
            return TaskCard(taskType: TaskType.canceled, taskModel: _cancelTaskList[index], onStatusUpdate: () {  },);
          }),
        ),
      ),
    );
  }
  Future<void>_getCancelTaskList()async{
    _getCancelTaskInProgress==true;
    setState(() { });
    NetworkResponse response=await NetworkCaller.postRequest(url: Urls.getCancelTaskListUrl);
    if(response.isSuccess){
      List<TaskModel>list=[];
      for(Map<String,dynamic>jsonData in response.body!['data']){
        list.add(TaskModel.formJson(jsonData));
      }
      _cancelTaskList=list;
    }
    else {
      ShowSnackBarMessage(context, response.errorMessage!);
    }
  }
}
