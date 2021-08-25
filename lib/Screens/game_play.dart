import 'package:flutter/material.dart';
import 'package:twee_owl_adventure/game/game.dart';

class GamePlay extends StatelessWidget {
  final TweeOwlGame _tweeOwlGame = TweeOwlGame();

  GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tweeOwlGame.widget,
    );
  }
}
