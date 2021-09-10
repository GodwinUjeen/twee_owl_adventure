import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twee_owl_adventure/Screens/loginPage.dart';
import 'package:twee_owl_adventure/Screens/main_menu.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final Gradient gradient = LinearGradient(colors: [
    Color.fromRGBO(252, 186, 3, 1),
    Color.fromRGBO(252, 61, 3, 1),
  ]);



  Widget getScreenId() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return MainMenu();
        } else if (snapshot.hasError) {
          return LoginPage();
        } else {
          return LoginPage();
        }
      },
    );
  }

  void initState() {
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        PageTransition(
          child: getScreenId(),
          type: PageTransitionType.leftToRightWithFade,
        ),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
            ),
            ShaderMask(
              shaderCallback: (bounds) => gradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Text(
                'Twee Owl\nAdventure',
                style: TextStyle(
                    // The color must be set to white for this to work
                    // color: Colors.white,
                    fontSize: 60,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4
                      ..color = Colors.white,
                    shadows: [
                      Shadow(
                          // bottomLeft
                          offset: Offset(-0.1, -0.1),
                          color: Colors.white),
                      Shadow(
                          // bottomRight
                          offset: Offset(0.1, -0.1),
                          color: Colors.white),
                      Shadow(
                          // topRight
                          offset: Offset(0.1, 0.1),
                          color: Colors.white),
                      Shadow(
                          // topLeft
                          offset: Offset(-0.1, 0.1),
                          color: Colors.white),
                    ]),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/images/tweeOwl.gif',
              height: 80,
              width: 80,
            )
          ],
        ),
      ),
    );
  }
}
