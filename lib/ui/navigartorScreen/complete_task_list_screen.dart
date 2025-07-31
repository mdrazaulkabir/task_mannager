import 'package:flutter/material.dart';
import 'package:task_mannager/data/service/network_caller.dart';
import 'package:task_mannager/ui/widgets/center_circular_Progress_indicator.dart';
import 'package:task_mannager/ui/widgets/show_snack_bar_massanger.dart';

import '../../data/model/task_model.dart';
import '../../data/urls.dart';
import '../widgets/task_card.dart';
class CompleteTaskListScreen extends StatefulWidget {
  const CompleteTaskListScreen({super.key});
  static const String name='completeTaskListScreen';
  @override
  State<CompleteTaskListScreen> createState() => _CompleteTaskListScreenState();
}

class _CompleteTaskListScreenState extends State<CompleteTaskListScreen> {
  bool _getCompleteTaskInProgress=false;
  List<TaskModel>_completeTaskList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_getCompleteTaskList();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCompleteTaskList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: TMAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Visibility(
          visible: _getCompleteTaskInProgress==false,
          replacement: const CenterCircularProgressIndicator(),
          child: ListView.builder(
              itemCount: _completeTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskType: TaskType.complete,
                  taskModel: _completeTaskList[index],
                  onStatusUpdate: () {
                    _getCompleteTaskList();
                  },
                );
              }),
        ),
      ),
    );
  }
  Future<void>_getCompleteTaskList()async{
    _getCompleteTaskInProgress=true;
    setState(() {});
    NetworkResponse response=await NetworkCaller.getRequest(url: Urls.getCompleteTaskListUrl);

    if(response.isSuccess){
      List<TaskModel>list=[];
      for(Map<String,dynamic>jsonData in response.body!['data']){
        list.add(TaskModel.fromJson(jsonData));
      }
      _completeTaskList=list;
    }
    else{
      ShowSnackBarMessage(context, response.errorMessage!);
    }
    _getCompleteTaskInProgress=false;
    setState(() {});
  }
}
