import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_mannager/data/model/verification_data_model.dart';
import 'package:task_mannager/ui/screeen/pin_verification.dart';
import 'package:task_mannager/ui/widgets/center_circular_Progress_indicator.dart';
import 'package:task_mannager/ui/widgets/defalut_widget_rich_text.dart';
import 'package:task_mannager/ui/widgets/screen_background.dart';

import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../widgets/show_snack_bar_massanger.dart';
class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

static const String name='EmailScreen';
  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailTEController=TextEditingController();
  final GlobalKey<FormState>_formkey=GlobalKey<FormState>();
  bool emailInProgress=false;
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
                  if(value?.trim().isEmpty?? true){
                    return "Enter valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              Visibility(
                visible: emailInProgress==false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: ElevatedButton(
                      onPressed: _onTapPinVerificationButoon,
                      child: const Icon(Icons.arrow_circle_right_outlined))),
              const SizedBox(height: 20,),
              const DefalutWidgetRichText(),
            ],
          ),
        ),
      )),
    );
  }

  void _onTapPinVerificationButoon() {
    if (_formkey.currentState!.validate()) {
      _getEmailApiCall();
    }
  }

  Future<void>_getEmailApiCall()async{
    emailInProgress=true;
    setState(() { });

    SharedPreferences sharedPre=await SharedPreferences.getInstance();
    String? token=sharedPre.getString("token")??'';
    NetworkResponse response=await NetworkCaller.getRequest(url:Urls.emailUrl(_emailTEController.text.trim()));


    if(response.isSuccess){
      emailInProgress=false;
     VerificationDataModel verificationDataModel=VerificationDataModel.fromJson(response.body!);
     String? getStatus=verificationDataModel.status;
     String? getData=verificationDataModel.data;
     if(getStatus=='success'){
       SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
       sharedPreferences.setString('email', _emailTEController.text.trim());

       if(mounted){
         _emailTEController.clear();
         ShowSnackBarMessage(context, "$getStatus $getData");
         await Future.delayed(Duration(seconds: 1));
         await Navigator.pushNamedAndRemoveUntil(context, PinVerification.name, (route) => false);
       }
     }
     else{
       if(mounted){
         emailInProgress=false;
         ShowSnackBarMessage(context, "$getStatus $getData");
       }
     }
    }
    else{
      if(mounted){
        emailInProgress=false;
        ShowSnackBarMessage(context, response.errorMessage!);
      }
    }

    emailInProgress=false;
    if(mounted){
      setState(() { });
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
  }
}
