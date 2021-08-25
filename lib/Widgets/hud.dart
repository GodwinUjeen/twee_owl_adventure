import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:twee_owl_adventure/game/audio_manager.dart';

class HUD extends StatelessWidget {
  final Function onPausePressed;
  final ValueNotifier<int>? life;

  final Gradient gradient = LinearGradient(colors: [
    Color.fromRGBO(255, 144, 29, 1),
    Color.fromRGBO(247, 188, 20, 1),
    Color.fromRGBO(255, 177, 37, 1),
    Color.fromRGBO(254, 209, 48, 1),
  ]);

  final Gradient highScoreGradient = LinearGradient(colors: [
    Color.fromRGBO(255, 144, 29, 1),
    Color.fromRGBO(247, 188, 20, 1),
    Color.fromRGBO(254, 209, 48, 1),
    Color.fromRGBO(252, 61, 3, 1),
  ]);

  HUD({Key? key, required this.onPausePressed, required this.life})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: 8.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 6.0, 0.0, 0.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromRGBO(254, 209, 48, 1),
                    boxShadow: [
                      BoxShadow(
                        // bottomLeft
                        offset: Offset(-1.0, -1.0),
                        color: Color.fromRGBO(255, 144, 29, 1),
                      ),
                      BoxShadow(
                        // bottomRight
                        offset: Offset(1.0, -1.0),
                        color: Color.fromRGBO(255, 144, 29, 1),
                      ),
                      BoxShadow(
                        // topRight
                        offset: Offset(1.0, 1.0),
                        color: Color.fromRGBO(255, 144, 29, 1),
                      ),
                      BoxShadow(
                        // topLeft
                        offset: Offset(-1.0, 1.0),
                        color: Color.fromRGBO(255, 144, 29, 1),
                      ),
                    ]),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      onPausePressed.call();
                    },
                    icon: Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Image.asset(
                    'assets/images/highScore.png',
                    width: 45,
                    height: 45,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: ShaderMask(
                    shaderCallback: (bounds) => gradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'High Score',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    // bottomLeft
                                    offset: Offset(-0.1, -0.1),
                                    color: Colors.black),
                                Shadow(
                                    // bottomRight
                                    offset: Offset(0.1, -0.1),
                                    color: Colors.black),
                                Shadow(
                                    // topRight
                                    offset: Offset(0.1, 0.1),
                                    color: Colors.black),
                                Shadow(
                                    // topLeft
                                    offset: Offset(-0.1, 0.1),
                                    color: Colors.black),
                              ]),
                        ),
                        ValueListenableBuilder(
                          valueListenable: AudioManager.instance.highScore!,
                          builder: (BuildContext context, int highScore,
                              Widget? child) {
                            return ShaderMask(
                              shaderCallback: (bounds) =>
                                  highScoreGradient.createShader(
                                Rect.fromLTWH(
                                    0, 0, bounds.width, bounds.height),
                              ),
                              child: Text(
                                '$highScore',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        ValueListenableBuilder(
          valueListenable: life!,
          builder: (BuildContext context, int value, Widget? child) {
            final list = <Widget>[];
            for (int i = 0; i < 5; ++i) {
              list.add(
                Icon(
                  Icons.favorite,
                  color: (i < value) ? Colors.red : Colors.black45,
                  size: 27,
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                children: list,
              ),
            );
          },
        )
      ],
    );
  }
}
