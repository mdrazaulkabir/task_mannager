import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_mannager/ui/screeen/splash_screen.dart';
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
      home: splashScreen(),
    );
  }
}
