import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_mannager/ui/screeen/pin_verification.dart';
import 'package:task_mannager/ui/widgets/defalut_widget_rich_text.dart';
import 'package:task_mannager/ui/widgets/screen_background.dart';
class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailTEController=TextEditingController();
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
              Text("Your Email Address",style: Theme.of(context).textTheme.titleLarge,),
              const Text("A 6 digit verification pin will send to your email address",style: TextStyle(color: CupertinoColors.inactiveGray),),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
                textInputAction: TextInputAction.next,
                controller: _emailTEController,
                validator: (String?value){
                  if(value?.isEmpty?? true){
                    return "Enter valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed:_onTapPinVerificationButoon, child:const Icon(Icons.arrow_circle_right_outlined)),
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
     Navigator.push(context, MaterialPageRoute(builder: (context)=>const PinVerification()));
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
  }
}
