import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/defalut_widget_rich_text.dart';
import '../widgets/screen_background.dart';
class PassWordScreen extends StatefulWidget {
  const PassWordScreen({super.key});

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
      body: ScreenBackground(child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 40,),
              Text("Set Password",style: Theme.of(context).textTheme.titleLarge,),
              Text("Minimum length password 8 character with latter and number commbination",style: TextStyle(color: CupertinoColors.inactiveGray),),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Password",
                ),
                textInputAction: TextInputAction.next,
                controller: _passwordTEController,
                validator: (String?value){
                  if(value?.isEmpty?? true){
                    return "Enter valid password";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                ),
                textInputAction: TextInputAction.next,
                controller: _confirmPassowordTEController,
                validator: (String?value){
                  if(value?.isEmpty?? true){
                    return "Enter valid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed:_onTapPinVerificationButoon, child:Icon(Icons.arrow_circle_right_outlined)),
              SizedBox(height: 20,),
              DefalutWidgetRichText(),
            ],
          ),
        ),
      )),
    );
  }
  void _onTapPinVerificationButoon(){
    if(_formkey.currentState!.validate()){

    }
  }
}
