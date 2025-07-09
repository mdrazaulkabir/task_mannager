import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_mannager/ui/screeen/pass_word_screen.dart';

import '../widgets/defalut_widget_rich_text.dart';
import '../widgets/screen_background.dart';
class PinVerification extends StatefulWidget {
  const PinVerification({super.key});
  static const String name="pinVerification";

  @override
  State<PinVerification> createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerification> {
  TextEditingController _pinOtpTEcontroller=TextEditingController();
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
              const SizedBox(height: 120,),
              Text("PIN Verification",style: Theme.of(context).textTheme.titleLarge,),
              const Text("A 6 digit verification pin will send to your email address",style: TextStyle(color: CupertinoColors.inactiveGray),),
              const SizedBox(height: 10,),
              PinCodeTextField(
                keyboardType: TextInputType.number,
                controller: _pinOtpTEcontroller,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.white,
                //enableActiveFill: true,
                appContext: context,  //must be give
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
    // if(_formkey.currentState!.validate()){
    //   Navigator.pushNamed(context, PassWordScreen.name);
    // }
    Navigator.pushNamed(context, PassWordScreen.name);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pinOtpTEcontroller.dispose();
  }
}
