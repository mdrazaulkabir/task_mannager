import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/defalut_widget_rich_text.dart';
import '../widgets/screen_background.dart';
class PinVerification extends StatefulWidget {
  const PinVerification({super.key});

  @override
  State<PinVerification> createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerification> {
  @override
  TextEditingController _pinNumber=TextEditingController();
  final GlobalKey<FormState>_formkey=GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 120,),
              Text("PIN Verification",style: Theme.of(context).textTheme.titleLarge,),
              const Text("A 6 digit verification pin will send to your email address",style: TextStyle(color: CupertinoColors.inactiveGray),),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
                textInputAction: TextInputAction.next,
                controller: _pinNumber,
                validator: (String?value){
                  if(value?.isEmpty?? true){
                    return "Enter valid email";
                  }
                },
              ),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed:_onTapPinVerificationButoon, child:const Text("Verify")),
              const SizedBox(height: 20,),
              const DefalutWidgetRichText(),
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
