import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_mannager/ui/screeen/sign_in_screen.dart';
import 'package:task_mannager/ui/ulits/asset_path.dart';
import 'package:task_mannager/ui/widgets/screen_background.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  void initState(){
    super.initState();
    moveToNextScreen();
  }
  Future<void>moveToNextScreen()async{
    await Future.delayed(Duration(seconds: 10));
    Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context)=>SignInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: Center(child: SvgPicture.asset(assetPath.logoSvg))),
    );
  }
}
