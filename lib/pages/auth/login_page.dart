import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_creator/utils/customColors.dart';
import 'package:qr_creator/service/auth_service.dart';
import 'package:qr_creator/widgets/custom_text_button.dart';
import 'package:qr_creator/utils/customTextStyle.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email, password;
  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    String topImage = "assets/topImage.png";
    return Scaffold(
      body: appBody(height, topImage),
    );
  }

  SingleChildScrollView appBody(double height, String topImage) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topImageContainer(height, topImage),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    titleText(),
                    customSizedBox(),
                    emailTextField(),
                    customSizedBox(),
                    passwordTextField(),
                    customSizedBox(),
                    forgotPasswordButton(),
                    customSizedBox(),
                    signInButton(),
                    customSizedBox(),
                    CustomTextButton(
                      onPressed: () => Navigator.pushNamed(context, "/signUp"),
                      buttonText: "Create new Account",
                    ),
                    CustomTextButton(
                        onPressed: () async {
                          final result = await authService.signInAnonymous();
                          if (result != null) {
                            Navigator.pushReplacementNamed(
                                context, "/homePage");
                          } else {
                            print("Error!");
                          }
                        },
                        buttonText: "Guest")
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text titleText() {
    return Text(
      "Welcome, \nPlease Enter",
      style: CustomTextStyle.titleTextStyle,
    );
  }

  TextFormField emailTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "This area is a required";
        } else {}
      },
      onSaved: (value) {
        email = value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: customInputDecoration("E-mail"),
    );
  }

  TextFormField passwordTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "This area is a required";
        } else {}
      },
      onSaved: (value) {
        password = value!;
      },
      obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: customInputDecoration("Password"),
    );
  }

  Center forgotPasswordButton() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: customText(
          "Forgot Password?",
          CustomColors.textButtonColor,
        ),
      ),
    );
  }

  Center signInButton() {
    return Center(
      child: TextButton(
        onPressed: signIn,
        child: Container(
          height: 50,
          width: 150,
          margin: EdgeInsets.symmetric(horizontal: 60),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(0xff31274F)),
          child: Center(
            child: customText("Sign In", CustomColors.loginButtonTextColor),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      try {
        final userResult = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        Navigator.pushReplacementNamed(context, "/homePage");
        print(userResult.user!.email);
      } catch (e) {
        print(e.toString());
      }
    } else {}
  }

  Center signUpButton() {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, "/signUp"),
        child: customText(
          "Create new Account",
          CustomColors.textButtonColor,
        ),
      ),
    );
  }

  Container topImageContainer(double height, String topImage) {
    return Container(
      height: height * .25,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(topImage),
        ),
      ),
    );
  }

  Widget customSizedBox() => SizedBox(
    height: 20,
  );

  Widget customText(String text, Color color) => Text(
    text,
    style: TextStyle(color: color),
  );

  InputDecoration customInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
    );
  }
}