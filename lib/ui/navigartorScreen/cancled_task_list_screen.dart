import 'package:flutter/material.dart';
import 'package:task_mannager/data/service/network_caller.dart';
import 'package:task_mannager/ui/widgets/center_circular_Progress_indicator.dart';
import 'package:task_mannager/ui/widgets/show_snack_bar_massanger.dart';
import 'package:task_mannager/ui/widgets/task_card.dart';

import '../../data/model/task_model.dart';
import '../../data/urls.dart';
class CanceledTaskListScreen extends StatefulWidget {
  const CanceledTaskListScreen({super.key});
  static const String name='canceledTaskListScreen';
  @override
  State<CanceledTaskListScreen> createState() => _CanceledTaskListScreenState();
}

class _CanceledTaskListScreenState extends State<CanceledTaskListScreen> {
  bool _getCancelTaskInProgress=false;
  List<TaskModel>_cancelTaskList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCancelTaskList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: TMAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Visibility(
          visible: _getCancelTaskInProgress==false,
          replacement:const CenterCircularProgressIndicator(),
          child: ListView.builder(
              itemCount: _cancelTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskType: TaskType.canceled,
                  taskModel: _cancelTaskList[index],
                  onStatusUpdate: () {
                    _getCancelTaskList();
                  },
                );
              }),
        ),
      ),
    );
  }
  Future<void>_getCancelTaskList()async{
    _getCancelTaskInProgress=true;
    setState(() { });
    NetworkResponse response=await NetworkCaller.getRequest(url: Urls.getCancelTaskListUrl);

    if(response.isSuccess){
      List<TaskModel>list=[];
      for(Map<String,dynamic>jsonData in response.body!['data']){
        list.add(TaskModel.fromJson(jsonData));
      }
      _cancelTaskList=list;
    }
    else {
      ShowSnackBarMessage(context, response.errorMessage!);
    }
    _getCancelTaskInProgress=false;
    setState(() { });
  }
}
