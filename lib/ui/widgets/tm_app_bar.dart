import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_mannager/ui/controller/auth_controller.dart';
import 'package:task_mannager/ui/screeen/sign_in_screen.dart';
import 'package:task_mannager/ui/navigartorScreen/update_profile_screen.dart';

class TMAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
  });

  @override
  //Size get preferredSize => Size.fromHeight(100);    //this size will be take the appBar
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<TMAppBar> createState() => _TMAppBarState();
}

class _TMAppBarState extends State<TMAppBar> {
  @override
  Widget build(BuildContext context) {
    final user=AuthController.userModel;
    return AppBar(
      backgroundColor: Colors.greenAccent,
      title: GestureDetector(
        onTap: _onTabAppBarGestureDetector,
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: user?.photo == null ? null :
              MemoryImage(base64Decode(user!.photo!)),
              child: (user?.photo==null || user!.photo!.isNotEmpty)? const Icon(Icons.person,color: Colors.green,):null
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: Column(children: [
                Text(user?.fullName?? 'Guest',style: Theme.of(context).textTheme.titleMedium,),
                Text(user?.email?? "",style: Theme.of(context).textTheme.titleSmall),
              ],),
            ),
            const Spacer(),
            IconButton(onPressed: _onTapLogoutButton, icon: const Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
  Future<void> _onTapLogoutButton() async {
    await AuthController.clearData();
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (route) => false);
  }
  void _onTabAppBarGestureDetector(){
    if(ModalRoute.of(context)!.settings.name!=UpdateProfileScreen.name){
      Navigator.pushNamed(context, UpdateProfileScreen.name);
    }
  }
}