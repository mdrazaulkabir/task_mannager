import 'package:flutter/material.dart';
import 'package:task_mannager/ui/widgets/defalut_widget_rich_text.dart';
import 'package:task_mannager/ui/widgets/screen_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "Join With Us",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Email",
              ),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "First Name",
              ),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Last Name",
              ),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Mobile ",
              ),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Password",
              ),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){}, child: Icon(Icons.arrow_circle_right_outlined)),
            SizedBox(height: 20,),
            DefalutWidgetRichText(),
          ],
        ),
      )),
    );
  }
}
