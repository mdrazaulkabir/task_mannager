import 'package:flutter/material.dart';

import '../../data/model/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../widgets/show_snack_bar_massanger.dart';
import '../widgets/task_card.dart';
class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});
  static const String name='progressTaskListScreen';
  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {

  bool _getProgressTaskInprogress=false;
  List<TaskModel>_progressTaskList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProgressTaskList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: TMAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Visibility(
          visible: _getProgressTaskInprogress==false,
          replacement: Center(child: CircularProgressIndicator(),),
          child: ListView.builder(
              itemCount: _progressTaskList.length,
              itemBuilder: (context,index){
            return TaskCard(taskType: TaskType.progress,taskModel: _progressTaskList[index],);
          }),
        ),
      ),

    );
  }

  Future<void>_getProgressTaskList()async{
    _getProgressTaskInprogress=true;
    setState(() { });
    NetworkResponse response=await NetworkCaller.postRequest(url:Urls.getProgressTaskListUrl);

    if(response.isSuccess){
      List<TaskModel>list=[];
      for(Map<String,dynamic> jsonData in response.body!['data']){
        list.add(TaskModel.formJson(jsonData));
      }
      _progressTaskList=list;
    }
    else{
      ShowSnackBarMessage(context, response.errorMessage!);
    }

    _getProgressTaskInprogress=false;
    setState(() { });
  }


}
