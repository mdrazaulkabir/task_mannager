import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_mannager/data/profile.dart';
import 'package:task_mannager/ui/screeen/pass_word_screen.dart';
import 'package:task_mannager/ui/screeen/sign_up_screen.dart';
import 'package:task_mannager/ui/widgets/screen_background.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController=TextEditingController();
  final TextEditingController _passwordTEController=TextEditingController();
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formkey ,
            autovalidateMode:AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Get Started With",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextFormField(
                  controller: _emailTEController,
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (String? value){
                    if(value?.isEmpty?? true){
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordTEController,
                  decoration: InputDecoration(hintText: "Password"),
                  validator: (String? value){
                    if(value?.isEmpty?? 0<=6){
                      return "Enter valid password!";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: _onTapSignInButton,
                    child: Icon(
                      CupertinoIcons.arrow_right_circle,
                    )),
                SizedBox(
                  height: 40,
                ),
                TextButton(
                  onPressed: _onTapForgottButoon,
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(color: CupertinoColors.inactiveGray),    // vvi  If you want to override here
                  ),
                ),
                RichText(
                    text: TextSpan(
                        text: "Don't have account ? ",
                        style: TextStyle(
                            color: CupertinoColors.inactiveGray,
                            fontWeight: FontWeight.bold),
                        children: [
                      TextSpan(
                          text: "Signup",
                          style: TextStyle(color: Colors.greenAccent)),


                    ],
                      recognizer: TapGestureRecognizer()..onTap=_onTapSignUpButton,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _onTapSignInButton(){
    if(_formkey.currentState!.validate()){
     Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
    }
  }
  void _onTapForgottButoon(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>PassWordScreen()));

  }
  void _onTapSignUpButton(){
   Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
  }


}


