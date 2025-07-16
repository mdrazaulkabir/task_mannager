import 'package:flutter/material.dart';
import 'package:task_mannager/ui/controller/auth_controller.dart';
import 'package:task_mannager/ui/screeen/sign_in_screen.dart';
import 'package:task_mannager/ui/navigartorScreen/update_profile_screen.dart';

class TMAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
  });

  @override
  // TODO: implement preferredSize
  //Size get preferredSize => Size.fromHeight(100);    //this size will be take the appBar
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  State<TMAppBar> createState() => _TMAppBarState();
}

class _TMAppBarState extends State<TMAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.greenAccent,
      title: GestureDetector(
        onTap: _onTabAppBarGestureDetector,
        child: Row(
          children: [
            CircleAvatar(),
            SizedBox(width: 16,),
            Column(children: [
              Text(AuthController.userModel!.fullName,style: Theme.of(context).textTheme.titleMedium,),
              Text(AuthController.userModel!.email,style: Theme.of(context).textTheme.titleSmall),
            ],),
            Spacer(),
            IconButton(onPressed: _onTapLogoutButton, icon: Icon(Icons.logout))
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
    if(ModalRoute.of(context)?.settings.name!=UpdateProfileScreen.name){
      Navigator.pushNamed(context, UpdateProfileScreen.name);
    }
  }
}