import 'package:flutter/material.dart';
import 'package:task_mannager/ui/widgets/center_circular_Progress_indicator.dart';

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

  bool _getProgressTaskInProgress=false;
  List<TaskModel>_progressTaskList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getProgressTaskList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: TMAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Visibility(
          visible: _getProgressTaskInProgress==false,
          replacement: const CenterCircularProgressIndicator(),
          child: ListView.builder(
              itemCount: _progressTaskList.length,
              itemBuilder: (context,index){
                return TaskCard(
                  taskType: TaskType.progress,
                  taskModel: _progressTaskList[index],
                  onStatusUpdate: () {
                    _getProgressTaskList();
                  },
                );
              }),
        ),
      ),

    );
  }

  Future<void>_getProgressTaskList()async{
    _getProgressTaskInProgress=true;
    setState(() { });
    NetworkResponse response=await NetworkCaller.getRequest(url:Urls.getProgressTaskListUrl);

    if(response.isSuccess){
      List<TaskModel>list=[];
      for(Map<String,dynamic> jsonData in response.body!['data']){
        list.add(TaskModel.fromJson(jsonData));
      }
      _progressTaskList=list;
    }
    else{
      ShowSnackBarMessage(context, response.errorMessage!);
    }

    _getProgressTaskInProgress=false;
    setState(() { });
  }


}
