import 'package:qr_creator/pages/admin/user_register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_creator/pages/auth/login_page.dart';
import 'package:qr_creator/pages/auth/sign_up_page.dart';
import 'package:qr_creator/pages/admin//home_page.dart';
import 'package:qr_creator/utils/customColors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cauldron',
      routes: {
        "/loginPage": (context) => LoginPage(),
        "/signUp": (context) => SignUp(),
        "/homePage": (context) => HomePage(),
        "/userRegisterPage":(context) => UserRegister()
      },
      theme: ThemeData(
        scaffoldBackgroundColor: CustomColors.scaffoldBackgroundColor,
      ),
      home: Scaffold(
        body: LoginPage(),
      ),
    );
  }
}