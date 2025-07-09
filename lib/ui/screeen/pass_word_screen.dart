import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_mannager/ui/screeen/sign_in_screen.dart';

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
                ElevatedButton(onPressed:_onTapPasswordButtoon, child:const Icon(Icons.arrow_circle_right_outlined)),
                const SizedBox(height: 20,),
                const DefalutWidgetRichText(),
              ],
            ),
          ),
        ),
      )),
    );
  }
  void _onTapPasswordButtoon(){
    if(_formkey.currentState!.validate()){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInScreen()));
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
