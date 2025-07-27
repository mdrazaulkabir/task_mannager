import 'package:flutter/material.dart';
import 'package:task_mannager/data/service/network_caller.dart';
import 'package:task_mannager/data/urls.dart';
import 'package:task_mannager/ui/widgets/defalut_widget_rich_text.dart';
import 'package:task_mannager/ui/widgets/screen_background.dart';
import 'package:task_mannager/ui/widgets/show_snack_bar_massanger.dart';

import '../widgets/center_circular_Progress_indicator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String name='sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController=TextEditingController();
  final TextEditingController _firstNameTEController=TextEditingController();
  final TextEditingController _lastNameTEController=TextEditingController();
  final TextEditingController _mobileTEController=TextEditingController();
  final TextEditingController _passwordTEController=TextEditingController();
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  bool _signUpProgress=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formkey,
            autovalidateMode:AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                Text(
                  "Join With Us",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                  textInputAction: TextInputAction.next,
                  controller: _emailTEController,
                  validator: (String? value){
                    //if(value?.trim().isEmpty?? true){}
                    //if(value!.length<=6){}
                    if(value?.isEmpty?? true){
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "First Name",
                  ),
                  textInputAction: TextInputAction.next,
                  controller: _firstNameTEController,
                  validator: (String? value){
                    if(value?.isEmpty?? true){
                      return "Enter valid name!";
                    }
                    return null;
                  },

                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Last Name",
                  ),
                  textInputAction: TextInputAction.next,
                  controller: _lastNameTEController,
                  validator: (String? value){
                    if(value?.trim().isEmpty?? true){
                      return "Enter valid name!";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Mobile ",
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  controller: _mobileTEController,
                  validator: (String? value){
                    if(value!.length<=6){
                      return "Enter valid mobile number!";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  controller: _passwordTEController,
                  validator: (String? value){
                    if(value!.length<=6){
                      return "Enter valid password!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: _signUpProgress==false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: ElevatedButton(
                      onPressed: _onTapSignUpButton,
                      child: const Icon(Icons.arrow_circle_right_outlined)),
                ),
                const SizedBox(
                  height: 20,
                ),
                const DefalutWidgetRichText(),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void _onTapSignUpButton(){
    if(_formkey.currentState!.validate()){
      //Navigator.pushReplacementNamed(context, BottomMainNavScreen.name);
      _signUp();
    }
  }

  Future<void>_signUp()async{
    _signUpProgress=true;
    setState(() { });
    Map<String ,String>resquestBody={
      "email":_emailTEController.text.trim(),
      "firstName":_firstNameTEController.text.trim(),
      "lastName":_lastNameTEController.text.trim(),
      "mobile":_mobileTEController.text.trim(),
      "password":_passwordTEController.text,
    };
    NetworkResponse response=await NetworkCaller.postRequest(url:Urls.registrationUrl,  body: resquestBody);
    _signUpProgress=false;
    setState(() { });

    if(response.isSuccess){
      _clearTextField();
     ShowSnackBarMessage(context, "Registration has been sucess. Please login!");
    }
    else{
      ShowSnackBarMessage(context, response.errorMessage!);
    }
  }




  void _clearTextField(){
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _passwordTEController.clear();
    _mobileTEController.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();

  }
}
