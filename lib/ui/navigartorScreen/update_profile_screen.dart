import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker _imagePicker=ImagePicker();
  XFile? _selectedImage;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
                         Text(_selectedImage==null? "Select image":_selectedImage!.name),
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
                  controller: _emailTEController,
                  validator: (String? value) {
                    //if(value?.trim().isEmpty?? true){}
                    //if(value!.length<=6){}
                    if (value?.isEmpty ?? true) {
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
                    if (value!.length <= 6) {
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

  void _onTapUpdateButton() {
    if (_formkey.currentState!.validate()) {
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

    Future<void> _onTapImagePicker()async {
    final XFile? NowimagePicked=await _imagePicker.pickImage(source:ImageSource.camera);
    if(NowimagePicked!=null){
      _selectedImage=NowimagePicked;
      setState(() {

      });
     }
    }
}
