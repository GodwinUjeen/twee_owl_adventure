import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:twee_owl_adventure/Screens/game_play.dart';
import 'package:twee_owl_adventure/Widgets/exit_dialog.dart';

class Menu extends StatelessWidget {
  final Function onSettingsPressed;

  final Gradient gradient = LinearGradient(colors: [
    Color.fromRGBO(252, 186, 3, 1),
    Color.fromRGBO(252, 61, 3, 1),
  ]);

  Menu({
    Key? key,
    required this.onSettingsPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
          height: 3.0,
        ),
        MaterialButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => GamePlay(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.play_circle_outline_rounded,
                  size: 22.0,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  'Play',
                  style: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ],
            ),
          ),
          color: Colors.lightGreenAccent,
          elevation: 4.0,
          splashColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        MaterialButton(
          onPressed: () {
            onSettingsPressed();
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.settings_rounded,
                  size: 22.0,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ],
            ),
          ),
          color: Colors.lightGreenAccent,
          elevation: 4.0,
          splashColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        MaterialButton(
          onPressed: () {
            Provider.of<ExitDialog>(context, listen: false).exitDialog(context);
          },
          elevation: 4.0,
          splashColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.exit_to_app_rounded,
                  size: 22.0,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  'Exit',
                  style: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ],
            ),
          ),
          color: Colors.lightGreenAccent,
        ),
      ],
    );
  }
}
