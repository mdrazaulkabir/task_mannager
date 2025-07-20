import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_mannager/data/service/network_caller.dart';
import 'package:task_mannager/data/urls.dart';
import 'package:task_mannager/ui/widgets/show_snack_bar_massanger.dart';
import 'package:task_mannager/ui/widgets/tm_app_bar.dart';

import '../widgets/screen_background.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String name = 'addNewTaskScreen';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _addTaskProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                Text(
                  "Add New Task",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 6,
                ),
                //const Text("Minimum length password 8 character with latter and number commbination",style: TextStyle(color: CupertinoColors.inactiveGray),),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Subject",
                  ),
                  textInputAction: TextInputAction.next,
                  controller: _subjectTEController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Enter valid one subject!";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Description",
                  ),
                  maxLines: 5,
                  textInputAction: TextInputAction.next,
                  controller: _descriptionTEController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Give one valid description!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                    visible: _addTaskProgress==false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                        onPressed: _onTapNewTask,
                        child: const Icon(Icons.arrow_circle_right_outlined))),
                const SizedBox(
                  height: 20,
                ),
                //const DefalutWidgetRichText(),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void _onTapNewTask() {
    if (_formkey.currentState!.validate()) {
      //Navigator.pushNamed(context, NewTaskListScreen.name);
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    _addTaskProgress = true;
    setState(() {});
    Map<String,String>requestBody={
        "title":_subjectTEController.text.trim(),
        "description": _descriptionTEController.text.trim(),
        "status":"New"
      };
    NetworkResponse response=await NetworkCaller.postRequest(url:Urls.createNewTaskUrl ,body: requestBody);
    if(response.isSuccess){
      _subjectTEController.clear();
      _descriptionTEController.clear();
      ShowSnackBarMessage(context, "Successfully added new task");
    }
    else{
      ShowSnackBarMessage(context, response.errorMessage!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
  }
}
