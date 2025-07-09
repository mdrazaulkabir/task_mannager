import 'package:flutter/material.dart';
import 'package:task_mannager/ui/screeen/cancled_task_list_screen.dart';
import 'package:task_mannager/ui/screeen/complete_task_list_screen.dart';
import 'package:task_mannager/ui/screeen/progress_task_list_screen.dart';
import 'package:task_mannager/ui/widgets/tm_app_bar.dart';

import 'new_task_list_screen.dart';
class BottomMainNavScreen extends StatefulWidget {
  const BottomMainNavScreen({super.key});
  static const String name="bottomMainNav";

  @override
  State<BottomMainNavScreen> createState() => _BotomMainNavScreenState();
}

class _BotomMainNavScreenState extends State<BottomMainNavScreen> {
 final List<Widget>_screen=[
    NewTaskListScreen(),ProgressTaskListScreen(),CompleteTaskListScreen(),CancledTaskListScreen(),
  ];
  int _selectIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: _screen[_selectIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectIndex,
          onDestinationSelected: (int index){
          _selectIndex=index;
          setState(() {

          });
          },
          destinations: [
            NavigationDestination(icon:Icon(Icons.new_label_outlined), label:"New"),
            NavigationDestination(icon:Icon(Icons.production_quantity_limits), label:"Progress"),
            NavigationDestination(icon:Icon(Icons.done), label:"Complete"),
            NavigationDestination(icon:Icon(Icons.close), label:"Cancled"),
          ]),
    );
  }
}

