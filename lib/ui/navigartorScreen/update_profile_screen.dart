import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_mannager/data/service/network_caller.dart';
import 'package:task_mannager/data/urls.dart';
import 'package:task_mannager/ui/controller/auth_controller.dart';
import 'package:task_mannager/ui/widgets/center_circular_Progress_indicator.dart';
import 'package:task_mannager/ui/widgets/show_snack_bar_massanger.dart';
import 'package:task_mannager/ui/widgets/tm_app_bar.dart';

import '../widgets/screen_background.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String name = "updateProfileScreen";

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final ImagePicker _imagePicker=ImagePicker();
  XFile? _selectedImage;
  bool updateProfileInProgress=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTEController.text=AuthController.userModel?.email?? "";
    _firstNameTEController.text=AuthController.userModel?.firstName?? "";
    _lastNameTEController.text=AuthController.userModel?.lastName?? "";
    _mobileTEController.text=AuthController.userModel?.email?? "";
  }


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
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                GestureDetector(
                  onTap: _onTapImagePicker,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 100,
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          alignment: Alignment.center,
                          child: Text("Photo",style: Theme.of(context).textTheme.titleMedium,),
                        ),
                        const SizedBox(width: 5,),
                        Text(
                          _selectedImage == null ? "Select image" : _selectedImage!.name,
                          maxLines: 1,
                          style: const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                  textInputAction: TextInputAction.next,
                  enabled: false,
                  // controller: _emailTEController,
                  // validator: (String? value) {
                  //   //if(value?.trim().isEmpty?? true){}
                  //   //if(value!.length<=6){}
                  //   if (value?.isEmpty ?? true) {
                  //     return "Enter valid email";
                  //   }
                  //   return null;
                  // },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "First Name",
                  ),
                  textInputAction: TextInputAction.next,
                  controller: _firstNameTEController,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
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
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
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
                  validator: (String? value) {
                    if (value!.length <= 6) {
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
                  validator: (String? value) {
                    int length=value?.length??0;
                    if (length>0 && length <= 6) {
                      return "Enter valid password!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: updateProfileInProgress==false,
                  replacement: CenterCircularProgressIndicator(),
                  child: ElevatedButton(
                      onPressed: _onTapUpdateButton,
                      child: const Icon(Icons.arrow_circle_right_outlined)),
                ),
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

  void _onTapUpdateButton() {
    if (_formkey.currentState!.validate()) {
      _updateProfile();
    }
  }

  Future<void>_updateProfile()async{
    updateProfileInProgress=true;
    if(mounted){
      setState(() {});
    }
    Map<String,String>requestBody={
      "email":_emailTEController.text,
      "firstName":_firstNameTEController.text.trim(),
      "lastName":_lastNameTEController.text.trim(),
      "mobile":_mobileTEController.text.trim(),
    };
    if(_passwordTEController.text.isNotEmpty){
      requestBody['password']=_passwordTEController.text;
    }
    if(_selectedImage!=null){
      Uint8List imageByte=await _selectedImage!.readAsBytes();
      requestBody['photo']=base64Encode(imageByte);
    }
    NetworkResponse response=await NetworkCaller.postRequest(url: Urls.updateProfileUrl,body: requestBody);

    updateProfileInProgress=false;
    if(mounted){
      setState(() {});
    }
    if(response.isSuccess){
      _passwordTEController.clear();
      if(mounted){
        ShowSnackBarMessage(context, "Successfully update profile!");
      }
    }
    else{
      if(mounted){
        ShowSnackBarMessage(context, response.errorMessage!);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
  }

  Future<void> _onTapImagePicker() async {
    final XFile? NowimagePicked =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (NowimagePicked != null) {
      _selectedImage = NowimagePicked;
      setState(() {});
    }
  }


}
