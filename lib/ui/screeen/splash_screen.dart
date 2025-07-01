import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_mannager/ui/screeen/sign_in_screen.dart';
import 'package:task_mannager/ui/ulits/asset_path.dart';

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
    Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context)=>signInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            //'assets/images/background.svg',
            assetPath.backgroundSvg,
            fit: BoxFit.cover,
          ),
          Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(assetPath.logoSvg))
        ],
      ),
    );
  }
}
