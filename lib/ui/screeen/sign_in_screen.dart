import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_mannager/data/model/user_model.dart';
import 'package:task_mannager/data/service/network_caller.dart';
import 'package:task_mannager/data/urls.dart';
import 'package:task_mannager/ui/navigartorScreen/botom_main_nav_screen.dart';
import 'package:task_mannager/ui/screeen/email_screen.dart';
import 'package:task_mannager/ui/screeen/sign_up_screen.dart';
import 'package:task_mannager/ui/widgets/screen_background.dart';
import 'package:task_mannager/ui/widgets/show_snack_bar_massanger.dart';

import '../widgets/center_circular_Progress_indicator.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const String name='sign-in-screeen';
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController=TextEditingController();
  final TextEditingController _passwordTEController=TextEditingController();
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  bool _signinProgress=false;
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
                const SizedBox(
                  height: 120,
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
                  decoration: const InputDecoration(hintText: "Password"),
                  keyboardType: TextInputType.number,
                  validator: (String? value){
                    if(value?.isEmpty?? 0<=6){
                      return "Enter valid password!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: _signinProgress==false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: ElevatedButton(
                      onPressed: _onTapSignInButton,
                      child: const Icon(
                        CupertinoIcons.arrow_right_circle,
                      )),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextButton(
                  onPressed: _onTapForgottButoon,
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(color: CupertinoColors.inactiveGray),    // vvi  If you want to override here
                  ),
                ),
                RichText(
                    text: TextSpan(
                        text: "Don't have account ? ",
                        style: const TextStyle(
                            color: CupertinoColors.inactiveGray,
                            fontWeight: FontWeight.bold),
                        children: [
                      TextSpan(
                          text: "Signup",
                          style: const TextStyle(color: Colors.greenAccent),
                        recognizer: TapGestureRecognizer()..onTap=_onTapSignUpButton,

                      ),


                    ],
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
      _signIn();
     //Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
    }
  }

  Future<void> _signIn()async{
    _signinProgress=true;
    setState(() {

    });
    Map<String ,String>resquestBody={
      "email":_emailTEController.text.trim(),
      "password":_passwordTEController.text,
    };
    NetworkResponse response=await NetworkCaller().postRequest(url: Urls.loginUrl,body: resquestBody);
    if(response.isSuccess){
      UserModel userModel=UserModel.formJson(response.body!['data']);
      String token=response.body!['token'];
      Navigator.pushNamedAndRemoveUntil(context, BottomMainNavScreen.name, (route) => false);
    }
    else{
      _signinProgress==false;
      setState(() {

      });
      ShowSnackBarMessage(context, response.errorMessage!);
    }
  }

  void _onTapForgottButoon(){
    Navigator.pushReplacementNamed(context, EmailScreen.name);

  }
  void _onTapSignUpButton(){
   Navigator.pushNamed(context, SignUpScreen.name);   //You want the user to be able to go back to the previous screen (e.g., back button in the app bar).
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }
}


