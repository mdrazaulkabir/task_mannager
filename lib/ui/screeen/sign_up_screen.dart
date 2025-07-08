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
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              Text(
                "Join With Us",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "First Name",
                ),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Last Name",
                ),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Mobile ",
                ),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Password",
                ),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.arrow_circle_right_outlined)),
              const SizedBox(
                height: 20,
              ),
              const DefalutWidgetRichText(),
            ],
          ),
        ),
      )),
    );
  }
}
