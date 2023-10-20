import 'package:flutter/material.dart';
import 'package:qr_creator/utils/customTextStyle.dart';
import 'package:qr_creator/utils/customColors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            userRegisterButton(),
          ],
        ),
      ),
    );
  }

  Center userRegisterButton() {
    return Center(
      child: TextButton(
        onPressed: userRegister,
        child: customText(
          "Create New User",
          CustomColors.textButtonColor,
        ),
      ),
    );
  }

  void userRegister() async {
    Navigator.pushReplacementNamed(context, "/userRegisterPage");
  }

  Widget customText(String text, Color color) => Text(
    text,
    style: TextStyle(color: color),
  );
}
