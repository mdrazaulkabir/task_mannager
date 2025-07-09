//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_mannager/ui/screeen/sign_in_screen.dart';
import 'package:task_mannager/ui/ulits/asset_path.dart';
import 'package:task_mannager/ui/widgets/screen_background.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  static const String name = '/';

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  Future<void> moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    // Navigator.pushReplacementNamed(context, '/Sign-in');   //it's can possible to mistake.That's way we create static variable
    Navigator.pushReplacementNamed(context, SignInScreen.name); // You don't want the user to go back to the previous screen (e.g., after logging in or logging out).
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Center(child: SvgPicture.asset(assetPath.logoSvg))),
    );
  }
}
