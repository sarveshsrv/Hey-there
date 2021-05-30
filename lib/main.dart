import 'package:flutter/material.dart';
import 'package:HeyThere/screens/welcome_screen.dart';
import 'package:HeyThere/screens/login_screen.dart';
import 'package:HeyThere/screens/registration_screen.dart';
import 'package:HeyThere/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/welcome_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark().copyWith(
      //   textTheme: TextTheme(
      //     bodyText2: TextStyle(color: Colors.black54),
      //   ),
      // ),
      // home: WelcomeScreen(),
      //We can either use home or intialRoute at a time

      initialRoute: WelcomeScreen.id,
      // initialRoute: '/first',
      routes: {
        //'/first': (context) => WelcomeScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
