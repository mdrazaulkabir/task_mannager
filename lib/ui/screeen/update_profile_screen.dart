import 'package:flutter/material.dart';
import 'package:task_mannager/ui/widgets/tm_app_bar.dart';

import '../widgets/screen_background.dart';
class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});
  static const String name="updateProfileScreen";
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController=TextEditingController();
  final TextEditingController _firstNameTEController=TextEditingController();
  final TextEditingController _lastNameTEController=TextEditingController();
  final TextEditingController _mobileTEController=TextEditingController();
  final TextEditingController _passwordTEController=TextEditingController();

  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
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
                      height: 60,
                    ),
                    Text(
                      "Update Profile",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(
                      fixedSize:Size(40,40),
                      //padding: EdgeInsets.all(20)
                    ), child: Text('Photo'),),
                    const SizedBox(
                      height: 20,
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
                    ElevatedButton(
                        onPressed: _onTapUpdateButton,
                        child: const Icon(Icons.arrow_circle_right_outlined)),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
  void _onTapUpdateButton(){
    if(_formkey.currentState!.validate()){
     // Navigator.pushReplacementNamed(context, BottomMainNavScreen.name);
    }
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
