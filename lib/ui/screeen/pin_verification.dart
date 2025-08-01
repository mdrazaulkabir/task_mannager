import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_mannager/data/model/verification_data_model.dart';
import 'package:task_mannager/data/service/network_caller.dart';
import 'package:task_mannager/data/urls.dart';
import 'package:task_mannager/ui/screeen/pass_word_screen.dart';
import 'package:task_mannager/ui/widgets/center_circular_Progress_indicator.dart';
import 'package:task_mannager/ui/widgets/show_snack_bar_massanger.dart';
import '../widgets/defalut_widget_rich_text.dart';
import '../widgets/screen_background.dart';
class PinVerification extends StatefulWidget {
  const PinVerification({super.key});

  static const String name="pinVerification";

  @override
  State<PinVerification> createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerification> {
  final TextEditingController _pinOtpTEController=TextEditingController();
  final GlobalKey<FormState>_formKey=GlobalKey<FormState>();
  bool pinVerificationInProgress=false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 120,),
              Text("PIN Verification",style: Theme.of(context).textTheme.titleLarge,),
              const Text("A 6 digit verification pin will send to your email address",style: TextStyle(color: CupertinoColors.inactiveGray),),
              const SizedBox(height: 10,),
              PinCodeTextField(
                keyboardType: TextInputType.number,
                controller: _pinOtpTEController,
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
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.white,
                //enableActiveFill: true,
                appContext: context,  //must be give
              ),
              const SizedBox(height: 20,),
              Visibility(
                visible: pinVerificationInProgress==false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: ElevatedButton(
                      onPressed: _onTapPinVerificationButoon,
                      child: const Text("Verify"))),
              const SizedBox(height: 20,),
              const DefalutWidgetRichText(),
            ],
          ),
        ),
      )),
    );
  }
  void _onTapPinVerificationButoon(){
    if(_formKey.currentState!.validate()){
      pinVerificationApiCall();
    }
  }
  
  
  Future<void>pinVerificationApiCall()async{
    pinVerificationInProgress=true;
    setState(() {});
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String? Email=sharedPreferences.getString('email')??'';
    await sharedPreferences.setString("userOtp", _pinOtpTEController.text.trim());
    NetworkResponse response=await NetworkCaller.getRequest(url: Urls.otpUrl(Email, _pinOtpTEController.text.trim()));

    if(response.isSuccess){
      VerificationDataModel verificationDataModel=VerificationDataModel.fromJson(response.body!);
      String getStatus=verificationDataModel.status??'';
      String getData=verificationDataModel.data?? '';


      if(getStatus=='success'){
        pinVerificationInProgress=false;
        if(mounted){
          _pinOtpTEController.clear();
          ShowSnackBarMessage(context, "$getStatus $getData");
          ShowSnackBarMessage(context, "Now you can set your new Password!");
          await Future.delayed(Duration(seconds: 1));
          await Navigator.pushNamed(context, PassWordScreen.name);
        }
      }
      else{
        if(mounted){
          pinVerificationInProgress=false;
          ShowSnackBarMessage(context, "$getStatus $getData");
        }
      }


    }
    else{
      if(mounted){
        pinVerificationInProgress=false;
        ShowSnackBarMessage(context, response.errorMessage!);
      }
    }
    pinVerificationInProgress=false;
    if(mounted){
      setState(() {});
    }
  }
  
  @override
  void dispose() {
    super.dispose();
    _pinOtpTEController.dispose();
  }
}
