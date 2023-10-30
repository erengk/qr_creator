import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_creator/utils/customColors.dart';
import 'package:qr_creator/utils/customTextStyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({Key? key}) : super(key: key);

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  String firstName = "";
  String id = "";
  String lastName = "";
  String password = "123456";
  String phone = "0555-555-5555";

  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText(),
                    userIDTextField(),
                    passwordTextField(),
                    userFirstNameTextField(),
                    userLastNameTextField(),
                    userPhoneNumberTextField(),
                    CreateButton(),
                    backToLoginPage(),
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
      "Welcome, \nPlease Enter Boxes",
      style: CustomTextStyle.titleTextStyle,
    );
  }

  TextFormField passwordTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
        } else {
          password = value!;
        }
      },
      onSaved: (value) {
        password = value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: customInputDecoration("Password"),
    );
  }

  TextFormField userFirstNameTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "This area is a required";
        } else {
          firstName = value!;
        }
      },
      onSaved: (value) {
        firstName = value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: customInputDecoration("First Name"),
    );
  }

  TextFormField userLastNameTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "This area is a required";
        } else {
          lastName = value!;
        }
      },
      onSaved: (value) {
        lastName = value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: customInputDecoration("Last Name"),
    );
  }

  TextFormField userPhoneNumberTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
        } else {
          value = phone!;
        }
      },
      onSaved: (value) {
        phone = value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: customInputDecoration("Phone"),
    );
  }

  TextFormField userIDTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "This area is a required";
        } else {
          id = value!;
        }
      },
      onSaved: (value) {
        id = value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: customInputDecoration("ID"),
    );
  }


  //TODO: DROPDOWNBUTTON EKLE


  Center CreateButton() {
    return Center(
      child: TextButton(
        onPressed: signIn,
        child: customText(
          "Create new Account",
          CustomColors.textButtonColor,
        ),
      ),
    );
  }

  void signIn() async {
    if (formkey.currentState!.validate()) {
      addToDatabase(id, firstName, lastName, phone, password);
    } else {}
  }

  Future<String> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Kullanıcı başarıyla kaydedildi.
      print('Kullanıcı kaydedildi: ${userCredential.user?.email}');
      return userCredential.user!.uid;
    } catch (e) {
      // Kayıt işlemi sırasında hata oluştu.
      print('Hata: $e');
      return "null";
    }
  }

  void addToDatabase(String id, String firstName, String lastName, String phone,
      String password) async {

    String uid = await signUpWithEmailAndPassword(id+"@mail.com", password);

    if (uid == "null"){
      return ;
    }

    Map<String, String> users = {
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'id': id,
      'phone': phone,
      'role': "employee",
    };

    final dbRef = FirebaseFirestore.instance;
    dbRef
        .collection("users")
        .doc(uid)
        .set(users)
        .onError((e, _) => print("Error writing document: $e"));
  }



  String generateUniqueHash(String input) {
    final bytes = Uint8List.fromList(utf8.encode(input));
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Center backToLoginPage() {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, "/loginPage"),
        child: customText(
          "Login Page",
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
