import 'dart:ui';
import 'package:flame/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:twee_owl_adventure/Widgets/game_over.dart';
import 'package:twee_owl_adventure/Widgets/hud.dart';
import 'package:twee_owl_adventure/Widgets/pause_menu.dart';
import 'package:twee_owl_adventure/game/audio_manager.dart';
import 'package:twee_owl_adventure/game/enemy.dart';
import 'package:twee_owl_adventure/game/enemy_manager.dart';
import 'package:twee_owl_adventure/game/tweeOwl.dart';

class TweeOwlGame extends BaseGame with TapDetector, HasWidgetsOverlay {
  Owl? _owl;
  ParallaxComponent? _parallaxComponent;
  TextComponent? _scoreText;
  int? score;
  EnemyManager? _enemyManager;

  double _elapsedTime = 0.0;

  bool _isGameOver = false;
  bool _isGamePaused = false;

  TweeOwlGame() {
    _parallaxComponent = ParallaxComponent(
      [
        ParallaxImage('parallax/bg1.png'),
        ParallaxImage('parallax/bg2.png'),
        ParallaxImage('parallax/bg3.png'),
        ParallaxImage('parallax/bg4.png'),
        ParallaxImage('parallax/bg5.png'),
      ],
      baseSpeed: Offset(100, 0),
      layerDelta: Offset(20, 0),
    );

    add(_parallaxComponent!);

    _owl = Owl();
    add(_owl!);

    _enemyManager = EnemyManager();
    add(_enemyManager!);

    score = 0;
    _scoreText = TextComponent(
      score.toString(),
      config: TextConfig(
        fontFamily: 'Audiowide',
        color: Colors.white,
        fontSize: 32,
      ),
    );
    add(_scoreText!);

    addWidgetOverlay('Hud', HUD(onPausePressed: pauseGame, life: _owl!.life));

    AudioManager.instance.startBgm('8Bit Platformer Loop.wav');
  }

  @override
  void resize(Size size) {
    // TODO: implement resize
    super.resize(size);
    _scoreText!.setByPosition(
        Position(((size.width / 2) - (_scoreText!.width / 2)), 0));
  }

  @override
  void onTapDown(TapDownDetails details) {
    // TODO: implement onTapDown
    super.onTapDown(details);
    if (!_isGameOver && !_isGamePaused) {
      _owl!.jump();
    }
  }

  @override
  void update(double t) {
    // TODO: implement update
    super.update(t);

    _elapsedTime += t;
    if (_elapsedTime > (1 / 60)) {
      _elapsedTime = 0.0;
      score = score! + 1;
      _scoreText!.text = score.toString();
    }
    _scoreText!.text = score.toString();

    components.whereType<Enemy>().forEach((enemy) {
      if (_owl!.distance(enemy) < 30) {
        _owl!.hit();
      }
    });

    if (_owl!.life!.value <= 0) {
      gameOver();
    }
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        this.pauseGame();
        break;
      case AppLifecycleState.paused:
        this.pauseGame();
        break;
      case AppLifecycleState.detached:
        this.pauseGame();
        break;
    }
  }

  void pauseGame() {
    pauseEngine();
    _isGamePaused = true;
    if (!_isGameOver) {
      addWidgetOverlay(
          'PauseMenu',
          PauseMenu(
            onResumePressed: resumeGame,
            onRestartGame: restartGame,
          ));
    }

    AudioManager.instance.pauseBgm();
  }

  void restartGame() {
    reset();
    removeWidgetOverlay('PauseMenu');
    resumeEngine();
  }

  void resumeGame() {
    removeWidgetOverlay('PauseMenu');
    _isGamePaused = false;
    resumeEngine();
    AudioManager.instance.resumeBgm();
  }

  void gameOver() {
    pauseEngine();
    _isGameOver = true;

    addWidgetOverlay(
        'GameOverMenu', GameOverMenu(score: score, onRestartPressed: reset));
    AudioManager.instance.pauseBgm();
    AudioManager.instance.setHighScore(score!);
  }

  void reset() {
    this.score = 0;
    _owl!.life!.value = 5;
    _owl!.run();
    _enemyManager!.reset();
    components.whereType<Enemy>().forEach((enemy) {
      this.markToRemove(enemy);
    });

    removeWidgetOverlay('GameOverMenu');
    _isGameOver = false;

    resumeEngine();
    AudioManager.instance.resumeBgm();
  }

  @override
  void onDetach() {
    // TODO: implement onDetach
    AudioManager.instance.stopBgm();
    super.onDetach();
  }
}
