import 'package:flutter/material.dart';
import 'package:task_mannager/data/service/network_caller.dart';
import 'package:task_mannager/data/urls.dart';
import 'package:task_mannager/ui/navigartorScreen/add_new_task_screen.dart';
import 'package:task_mannager/ui/widgets/center_circular_Progress_indicator.dart';
import 'package:task_mannager/ui/widgets/show_snack_bar_massanger.dart';
import '../../data/model/task_model.dart';
import '../../data/model/task_status_count_model.dart';
import '../widgets/default_task_count_summary_card.dart';
import '../widgets/task_card.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});
  static const String name='newTaskListScreen';

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {

  bool _getNewTaskInProgress=false;
  bool _getTaskStatusCountInProgress=false;

  List<TaskModel>_newTaskList=[];
  List<TaskStatusCountModel>_newTaskStatusCountList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getNewTaskList();
      _getTaskStatusCountList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 110,
            child: Visibility(
              visible: _getTaskStatusCountInProgress==false,
              replacement: const CenterCircularProgressIndicator(),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 15),
                itemCount: _newTaskStatusCountList.length,
                itemBuilder: (context, index) {
                  return DefaultTaskCountSummaryCard(
                    title: _newTaskStatusCountList[index].id,
                    count: _newTaskStatusCountList[index].count
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Visibility(
              visible: _getNewTaskInProgress==false,
              replacement: const CenterCircularProgressIndicator(),
              child: ListView.builder(
                  itemCount: _newTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskType: TaskType.tNew,
                      taskModel: _newTaskList[index],
                      onStatusUpdate: () {
                        _getNewTaskList();
                        _getTaskStatusCountList();
                      },
                    );
                  }),
            ),
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




  Future<void>_getNewTaskList()async{
    _getNewTaskInProgress=true;
    if(mounted) {setState(() { });}
    NetworkResponse response=await NetworkCaller.getRequest(url:Urls.getNewTaskListUrl);

    if(response.isSuccess){
      List<TaskModel>list=[];
      for(Map<String,dynamic> jsonData in response.body!['data']){
        try{
          list.add(TaskModel.fromJson(jsonData));
        }catch(e){
          print("Error parsing model:$e");
        }
      }
      _newTaskList=list;
      // print("Check api #############################:${_newTaskList.length} ");
      // print("Check api #############################:${response.body}");
    }
    else{
      if(mounted){
        ShowSnackBarMessage(context, response.errorMessage!);
      }
    }

    _getNewTaskInProgress=false;
    if(mounted){
      setState(() { });
    }
  }



  Future<void>_getTaskStatusCountList()async{
    _getTaskStatusCountInProgress=true;
    setState(() {});
    NetworkResponse response=await NetworkCaller.getRequest(url: Urls.getTaskStatusCountListUrl);
    if(response.isSuccess){
     List<TaskStatusCountModel>list=[];
     for(Map<String,dynamic>jsonData in response.body!['data']){
       print("###### Check ##########$jsonData");
        list.add(TaskStatusCountModel.formJson(jsonData));
     }
     _newTaskStatusCountList=list;
    }
    else{
      if(mounted){
        ShowSnackBarMessage(context, response.errorMessage!);
      }
    }
    _getTaskStatusCountInProgress=false;
    if(mounted){
      setState(() { });
    }
  }


  void _onTapFloatingActionButton(){
    // Navigator.pushNamedAndRemoveUntil(context, AddNewTaskScreen.name, (route) => false);  //all remove then got to this screen that's way will be no came back the previous screen
    Navigator.pushNamed(context, AddNewTaskScreen.name);
  }
}
