import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_mannager/data/service/network_caller.dart';
import 'package:task_mannager/ui/screeen/sign_in_screen.dart';
import 'package:task_mannager/ui/widgets/center_circular_Progress_indicator.dart';
import 'package:task_mannager/ui/widgets/show_snack_bar_massanger.dart';

import '../../data/urls.dart';
import '../widgets/defalut_widget_rich_text.dart';
import '../widgets/screen_background.dart';
class PassWordScreen extends StatefulWidget {
  const PassWordScreen({super.key});
  static const String name="passwordScreen";

  @override
  State<PassWordScreen> createState() => _PassWordScreenState();
}

class _PassWordScreenState extends State<PassWordScreen> {
  final TextEditingController _passwordTEController=TextEditingController();
  final TextEditingController _confirmPassowordTEController=TextEditingController();
  final GlobalKey<FormState>_formkey=GlobalKey<FormState>();
  bool passwordInProgress=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 120,),
                Text("Set Password",style: Theme.of(context).textTheme.titleLarge,),
                const Text("Minimum length password 8 character with latter and number commbination",style: TextStyle(color: CupertinoColors.inactiveGray),),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                  textInputAction: TextInputAction.next,
                  controller: _passwordTEController,
                  validator: (String? value){
                    if((value?.length?? 0)<=6){
                      return "Enter valid password!";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Confirm Password",
                  ),
                  textInputAction: TextInputAction.next,
                  controller: _confirmPassowordTEController,
                  validator: (String?value){
                    if((value?? '') != _passwordTEController.text){
                      return "Don't match the password. Try again!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                Visibility(
                  visible: passwordInProgress==false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: ElevatedButton(
                      onPressed: _onTapPasswordButtoon,
                      child: const Icon(Icons.arrow_circle_right_outlined)),
                ),
                const SizedBox(height: 20,),
                const DefalutWidgetRichText(),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void _onTapPasswordButtoon() {
    if (_formkey.currentState!.validate()) {
      _getTapPasswordApi();
    }
  }

  Future<void>_getTapPasswordApi()async{
    passwordInProgress=true;
    setState(() { });

    Map<String,String>requestBody={
      "password":_passwordTEController.text.trim()
    };
    // "email":"email@gmail.com",
    // "OTP": "190828",
    // "password":"12212221"

    NetworkResponse response=await NetworkCaller.postRequest(url: Urls.baseUrl,body: requestBody);
    passwordInProgress=false;
    setState(() { });
    if(response.isSuccess){
      _passwordTEController.clear();
      ShowSnackBarMessage(context, "Successfully reset your password!");
    }
    else{
      ShowSnackBarMessage(context, response.errorMessage!);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordTEController.dispose();
    _confirmPassowordTEController.dispose();
  }
}
