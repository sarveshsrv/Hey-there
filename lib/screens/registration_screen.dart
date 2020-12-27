import 'package:HeyThere/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:HeyThere/components/rounded_button.dart';
import 'package:HeyThere/constants.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                  //Do something with the user input.
                },
                decoration: kTextfieldDecoration.copyWith(
                    hintText: 'Enter your Email.'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: kTextfieldDecoration.copyWith(
                    hintText: 'Enter your password.'),
              ),
              SizedBox(
                height: 24.0,
              ),
              // RoundedButton(
              //   colour: Colors.indigo[300],
              //   title: 'Register',
              //   onPressed: () async {
              //     setState(() {
              //       showSpinner = true;
              //     });

              //     try {
              //       final newUser = await _auth.createUserWithEmailAndPassword(
              //           email: email, password: password);
              //       if (newUser != null) {
              //         Navigator.pushNamed(context, ChatScreen.id);
              //       }
              //       // print(email);
              //       // print(password);
              //     } catch (e) {
              //       print(e);
              //     }
              //     setState(() {
              //       showSpinner = false;
              //     });
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}