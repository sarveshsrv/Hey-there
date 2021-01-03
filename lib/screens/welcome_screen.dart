//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:HeyThere/screens/welcome_screen.dart';
import 'package:HeyThere/screens/login_screen.dart';
import 'package:HeyThere/screens/registration_screen.dart';
import 'package:HeyThere/screens/chat_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:HeyThere/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  //for curved animation
  Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: _WelcomeScreenState(),
      // Or

      // vsync:this,

      //lowerBound: 50,
      //upperbound can't be more than 1 when using curved animation and hence no need to use this as its 1 by default
      //upperBound: 100,
    );
    // animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    //Tween Animation
    animation =
        ColorTween(begin: Colors.deepOrangeAccent, end: Colors.lightBlue[100])
            .animate(controller);
    //If i want to animate from smaller to larger
    controller.forward();
    //If i want to animate from larger to smaller
    //controller.reverse(from: 1.0);

    //If we want to animate in a mixed way in a loop, then:

    /* controller.addStatusListener((status) {
      //print(status);
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });*/

    controller.addListener(() {
      setState(() {});
      // print(controller.value);
      print(animation.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                        child: Image.asset('images/logo.png'),
                        //height: controller.value),
                        //For curved animation, we use animation.value
                        //Multiply with 100 or any large number to see the proper change
                        // height: animation.value * 100),
                        height: 40),
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              colour: Colors.teal[200],
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              title: 'Register',
              colour: Colors.teal[400],
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
