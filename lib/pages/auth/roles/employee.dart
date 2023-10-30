import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_creator/pages/auth/login_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Employee extends StatefulWidget {

  final String uid;

  const Employee({super.key, required this.uid});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Personel QR Kodu'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              QrImageView(
                data: widget.uid,
                version: QrVersions.auto,
                size: 250,
              ),
              SizedBox(height: 20),
              Text('Yukarıdaki QR kodunu taratabilirsiniz!', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }





  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}