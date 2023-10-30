import 'package:flutter/material.dart';
import 'package:qr_creator/utils/customColors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScannerRedirectPage extends StatefulWidget {
  const ScannerRedirectPage({super.key});

  @override
  State<ScannerRedirectPage> createState() => _ScannerRedirectPageState();
}

class _ScannerRedirectPageState extends State<ScannerRedirectPage> {
  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR KOD OKUYUCU MENU"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            girisScanner(),
            yemekScanner(),
          ],
        ),
      ),
    );
  }

  Center girisScanner() {
    return Center(
      child: TextButton(
        onPressed: scanGirisQRCode,
        child: customText(
          "Giriş",
          CustomColors.textButtonColor,
        ),
      ),
    );
  }

  Widget customText(String text, Color color) => Text(
    text,
    style: TextStyle(color: color),);



  Center yemekScanner() {
    return Center(
      child: TextButton(
        onPressed: scanYemekQRCode,
        child: customText(
          "Yemek",
          CustomColors.textButtonColor,
        ),
      ),
    );
  }

  void scanYemekQRCode() {
    Navigator.pushReplacementNamed(context, "/qrScannerPage", arguments: "yemek");
  }

  void scanGirisQRCode() {
    Navigator.pushReplacementNamed(context, "/qrScannerPage", arguments: "giris");
  }
}
