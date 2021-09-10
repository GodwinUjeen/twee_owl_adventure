import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:twee_owl_adventure/Screens/main_menu.dart';
import 'package:twee_owl_adventure/Services/FirebaseServices.dart';
import 'package:share/share.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Gradient gradient = LinearGradient(colors: [
    Color.fromRGBO(252, 186, 3, 1),
    Color.fromRGBO(252, 61, 3, 1),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreenAccent,
        elevation: 2.0,
        onPressed: () async {
          var link = await Provider.of<FirebaseServices>(context, listen: false)
              .getLink();

          Share.share(link!);
        },
        splashColor: Colors.transparent,
        child: Icon(
          Icons.share,
          color: Colors.black,
        ),
      ),
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
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 80,
                ),
                ShaderMask(
                  shaderCallback: (bounds) => gradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: Text(
                    ' Twee Owl\nAdventure',
                    style: TextStyle(
                        fontSize: 44,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/tweeOwl.gif',
                      height: 80,
                      width: 80,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 200.0),
              child: Divider(
                color: Colors.white,
              ),
            ),
            Text(
              'Login (or) SignUp\nwith',
              style: TextStyle(color: Colors.white, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
              onPressed: () async {
                final provider =
                    Provider.of<FirebaseServices>(context, listen: false);
                User? user = await provider.googleLogin();

                if (user != null) {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: MainMenu(),
                      type: PageTransitionType.leftToRightWithFade,
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: LoginPage(),
                      type: PageTransitionType.leftToRightWithFade,
                    ),
                  );
                }
              },
              child: CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/images/google.jpg'),
              ),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(4),
                primary: Colors.white,
                onPrimary: Colors.white,
              ),
            ),
            Text(
              'Google',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
