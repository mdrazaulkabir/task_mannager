import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DefalutWidgetRichText extends StatelessWidget {
  const DefalutWidgetRichText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: "Have account? ",
            style: TextStyle(color: CupertinoColors.inactiveGray),
            children: [
          TextSpan(text: "Sign in", style: TextStyle(color: Colors.green))
        ],
          recognizer: TapGestureRecognizer()..onTap=_moveToSignInButton,
        ),

    );
  }
  void _moveToSignInButton(){

  }
}
