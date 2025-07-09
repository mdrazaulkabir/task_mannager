import 'package:flutter/material.dart';
import 'package:task_mannager/ui/screeen/sign_in_screen.dart';

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
      title: Row(
        children: [
          CircleAvatar(),
          SizedBox(width: 16,),
          Column(children: [
            Text("Md Razaul Kabir",style: Theme.of(context).textTheme.titleMedium,),
            Text("razaulkabir@gmail.com",style: Theme.of(context).textTheme.titleSmall),
          ],),
          Spacer(),
          IconButton(onPressed: _onTapLogoutButton, icon: Icon(Icons.logout))
        ],
      ),
    );
  }
  void _onTapLogoutButton(){
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (route) => false);
  }
}