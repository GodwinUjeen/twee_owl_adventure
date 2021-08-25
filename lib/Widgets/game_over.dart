import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twee_owl_adventure/Screens/main_menu.dart';
import 'package:twee_owl_adventure/Widgets/exit_dialog.dart';
import 'package:twee_owl_adventure/game/audio_manager.dart';

class GameOverMenu extends StatelessWidget {
  final int? score;
  final Function onRestartPressed;

  final Gradient gradient = LinearGradient(colors: [
    Color.fromRGBO(252, 186, 3, 1),
    Color.fromRGBO(252, 61, 3, 1),
  ]);

  GameOverMenu({
    Key? key,
    required this.score,
    required this.onRestartPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Colors.brown, width: 6)),
        color: Color.fromRGBO(255, 255, 204, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => gradient.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
                child: Text(
                  'Game Over',
                  style: TextStyle(
                    fontSize: 40,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = Colors.white,
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: AudioManager.instance.highScore!,
                builder: (BuildContext context, int highScore, Widget? child) {
                  return Text(
                    'HighScore $highScore',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black87,
                    ),
                  );
                },
              ),
              Text(
                'Your score was $score',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Retry',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(252, 186, 3, 1),
                            boxShadow: [
                              BoxShadow(
                                  // bottomLeft
                                  offset: Offset(-1.0, -1.0),
                                  color: Colors.white),
                              BoxShadow(
                                  // bottomRight
                                  offset: Offset(1.0, -1.0),
                                  color: Colors.white),
                              BoxShadow(
                                  // topRight
                                  offset: Offset(1.0, 1.0),
                                  color: Colors.white),
                              BoxShadow(
                                  // topLeft
                                  offset: Offset(-1.0, 1.0),
                                  color: Colors.white),
                            ]),
                        child: IconButton(
                          onPressed: () {
                            onRestartPressed.call();
                          },
                          icon: Icon(
                            Icons.replay_rounded,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Main Menu',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.lightGreen,
                            boxShadow: [
                              BoxShadow(
                                  // bottomLeft
                                  offset: Offset(-1.0, -1.0),
                                  color: Colors.white),
                              BoxShadow(
                                  // bottomRight
                                  offset: Offset(1.0, -1.0),
                                  color: Colors.white),
                              BoxShadow(
                                  // topRight
                                  offset: Offset(1.0, 1.0),
                                  color: Colors.white),
                              BoxShadow(
                                  // topLeft
                                  offset: Offset(-1.0, 1.0),
                                  color: Colors.white),
                            ]),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainMenu(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.menu,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Exit',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(252, 61, 3, 1),
                            boxShadow: [
                              BoxShadow(
                                  // bottomLeft
                                  offset: Offset(-1.0, -1.0),
                                  color: Colors.white),
                              BoxShadow(
                                  // bottomRight
                                  offset: Offset(1.0, -1.0),
                                  color: Colors.white),
                              BoxShadow(
                                  // topRight
                                  offset: Offset(1.0, 1.0),
                                  color: Colors.white),
                              BoxShadow(
                                  // topLeft
                                  offset: Offset(-1.0, 1.0),
                                  color: Colors.white),
                            ]),
                        child: IconButton(
                          onPressed: () {
                            Provider.of<ExitDialog>(context, listen: false)
                                .exitDialog(context);
                          },
                          icon: Icon(
                            Icons.close_rounded,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
