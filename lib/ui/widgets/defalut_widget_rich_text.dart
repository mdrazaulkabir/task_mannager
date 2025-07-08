import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_mannager/ui/screeen/sign_in_screen.dart';

class DefalutWidgetRichText extends StatefulWidget {
  const DefalutWidgetRichText({super.key});

  @override
  State<DefalutWidgetRichText> createState() => _DefalutWidgetRichTextState();
}

class _DefalutWidgetRichTextState extends State<DefalutWidgetRichText> {
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: "Have account? ",
            style: const TextStyle(color: CupertinoColors.inactiveGray),
            children:  [
          TextSpan(text: "Sign in", style: TextStyle(color: Colors.green),
            recognizer: TapGestureRecognizer()..onTap= _moveToSignInButton,
          )
        ],
         // recognizer: TapGestureRecognizer()..onTap=_moveToSignInButton,
        ),

    );
  }

  void _moveToSignInButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInScreen()));
  }
}
