import 'package:flutter/material.dart';
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
            qrScannerButton(),
            xmlBuilderButton(),
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

  Center qrScannerButton() {
    return Center(
      child: TextButton(
        onPressed: scanQRCode,
        child: customText(
          "Scan QR Code",
          CustomColors.textButtonColor,
        ),
      ),
    );
  }

  Center xmlBuilderButton() {
    return Center(
      child: TextButton(
        onPressed: xmlBuilder,
        child: customText(
          "Get XML File",
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

  void scanQRCode() {
    Navigator.pushReplacementNamed(context, "/ScannerRedirectPage");

    Widget customText(String text, Color color) => Text(
      text,
      style: TextStyle(color: color),);
  }

  void xmlBuilder() {
    Navigator.pushReplacementNamed(context, "/xmlBuilderPage");

    Widget customText(String text, Color color) => Text(
      text,
      style: TextStyle(color: color),);
  }
}
