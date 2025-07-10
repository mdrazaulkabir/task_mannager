import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_mannager/ui/navigartorScreen/add_new_task_screen.dart';
import 'package:task_mannager/ui/navigartorScreen/botom_main_nav_screen.dart';
import 'package:task_mannager/ui/navigartorScreen/cancled_task_list_screen.dart';
import 'package:task_mannager/ui/navigartorScreen/complete_task_list_screen.dart';
import 'package:task_mannager/ui/screeen/email_screen.dart';
import 'package:task_mannager/ui/navigartorScreen/new_task_list_screen.dart';
import 'package:task_mannager/ui/screeen/pass_word_screen.dart';
import 'package:task_mannager/ui/screeen/pin_verification.dart';
import 'package:task_mannager/ui/navigartorScreen/progress_task_list_screen.dart';
import 'package:task_mannager/ui/screeen/sign_in_screen.dart';
import 'package:task_mannager/ui/screeen/sign_up_screen.dart';
import 'package:task_mannager/ui/screeen/splash_screen.dart';
import 'package:task_mannager/ui/navigartorScreen/update_profile_screen.dart';
class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold)
        ),
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          //hintText: "Email",                                    vvi       //we can't text here only theme set here
          hintStyle: TextStyle(color: CupertinoColors.inactiveGray),
          contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 15), //we can padding here like take height and width
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),  //by default will be set in all textForm .
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: Colors.greenAccent,
            foregroundColor: Colors.white,
            // fixedSize: Size(double.maxFinite,35),
            fixedSize: Size.fromWidth(double.maxFinite),
            padding: EdgeInsets.symmetric(vertical: 15),  //we can easily take height and width

          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green
          )
        )
      ),
      debugShowCheckedModeBanner: false,
      //home: splashScreen(),
      initialRoute: splashScreen.name,
      routes: {                                              //first call the class name,, second this static variable,, then route this page
        //'/': (context)=>const splashScreen(),
        splashScreen.name:(context)=>const splashScreen(),
        //'/Sign-in':(context)=>const SignInScreen(),        //can be mistake the '/sign-in' the both place that's way we create one static variable for each class
        SignInScreen.name:(context)=>const SignInScreen(),
        SignUpScreen.name:(context)=>const SignUpScreen(),
        EmailScreen.name:(context)=>const EmailScreen(),
        PinVerification.name:(context)=>const PinVerification(),
        PassWordScreen.name:(context)=>const PassWordScreen(),
        BottomMainNavScreen.name:(context)=>const BottomMainNavScreen(),
        AddNewTaskScreen.name:(context)=>const AddNewTaskScreen(),
        UpdateProfileScreen.name:(context)=> const UpdateProfileScreen(),
        NewTaskListScreen.name:(context)=>const NewTaskListScreen(),
        CompleteTaskListScreen.name:(context)=>const CompleteTaskListScreen(),
        ProgressTaskListScreen.name:(context)=>const ProgressTaskListScreen(),
        CancledTaskListScreen.name:(context)=>const CancledTaskListScreen(),
      },
    );
  }
}
