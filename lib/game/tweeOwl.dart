import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame/time.dart';
import 'package:flutter/foundation.dart';
import 'package:twee_owl_adventure/Constants/constants.dart';
import 'package:twee_owl_adventure/game/audio_manager.dart';

class Owl extends AnimationComponent {
  Animation? _runAnimation;
  Animation? _hitAnimation;
  Timer? _timer;

  bool? _isHit;

  double speedY = 0.0;
  double yMax = 0.0;

  ValueNotifier<int>? life;

  Owl() : super.empty() {
    final owlRunSpriteSheet = SpriteSheet(
      imageName: 'Owlet_Monster_Run_6.png',
      textureWidth: 32,
      textureHeight: 32,
      columns: 6,
      rows: 1,
    );
    final owlHurtSpriteSheet = SpriteSheet(
      imageName: 'Owlet_Monster_Hurt_4.png',
      textureWidth: 32,
      textureHeight: 32,
      columns: 4,
      rows: 1,
    );

    _runAnimation =
        owlRunSpriteSheet.createAnimation(0, from: 0, to: 5, stepTime: 0.1);
    _hitAnimation =
        owlHurtSpriteSheet.createAnimation(0, from: 0, to: 3, stepTime: 0.1);
    this.animation = _runAnimation!;

    _timer = Timer(1, callback: () {
      run();
    });

    _isHit = false;
    this.anchor = Anchor.center;
    life = ValueNotifier(5);
  }

  @override
  void resize(Size size) {
    // TODO: implement resize
    super.resize(size);

    this.height = this.width = size.width / numberOfTilesAlongWidth;
    this.x = this.width;

    this.y = size.height -
        groundHeight -
        (this.height / 2) +
        tweeOwlTopBottomSpacing;
    this.yMax = this.y;
  }

  @override
  void update(double t) {
    // TODO: implement update
    super.update(t);
    //Final velocity = initial velocity + gravity * time (v = u + at)
    this.speedY += GRAVITY * t;

    //d = s0 + s * t
    this.y += this.speedY * t;

    if (isOnGround()) {
      this.y = this.yMax;
      this.speedY = 0.0;
    }
    _timer!.update(t);
  }

  bool isOnGround() {
    return (this.y >= this.yMax);
  }

  void run() {
    _isHit = false;
    this.animation = _runAnimation!;
  }

  void hit() {
    if (!_isHit!) {
      this.animation = _hitAnimation!;
      life!.value -= 1;
      AudioManager.instance.playSfx('hurt.wav');
      _timer!.start();
      _isHit = true;
    }
  }

  void jump() {
    if (isOnGround()) {
      AudioManager.instance.playSfx('jump.wav');
      this.speedY = -500;
    }
  }
}
