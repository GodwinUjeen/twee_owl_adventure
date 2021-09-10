import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AudioManager {

  AudioManager._internal();

  static AudioManager _instance = AudioManager._internal();

  static AudioManager get instance => _instance;

  void init(List<String> files) async {
    Flame.bgm.initialize();
    await Flame.audio.loadAll(files);

    _pref = await Hive.openBox('tweeOwlAdventure');

    if (_pref!.get('bgm') == null) {
      _pref!.put('bgm', true);
    }
    if (_pref!.get('sfx') == null) {
      _pref!.put('sfx', true);
    }
    if (_pref!.get('highScore') == null) {
      _pref!.put('highScore', 0);
    }
    _highScore = ValueNotifier(_pref!.get('highScore'));
    _sfx = ValueNotifier(_pref!.get('sfx'));
    _bgm = ValueNotifier(_pref!.get('bgm'));
  }

  Box? _pref;
  ValueNotifier<bool>? _sfx;
  ValueNotifier<bool>? _bgm;
  ValueNotifier<int>? _highScore;

  ValueNotifier<bool>? get listenableSfx => _sfx;

  ValueNotifier<bool>? get listenableBgm => _bgm;

  ValueNotifier<int>? get highScore => _highScore;

  void setSfx(bool flag) {
    _pref!.put('sfx', flag);
    _sfx!.value = flag;
  }

  void setBgm(bool flag) {
    _pref!.put('bgm', flag);
    _bgm!.value = flag;
  }

  void resetHighScore(int score) {
    _pref!.put('highScore', score);
    _highScore!.value = score;
  }

  void setHighScore(int score) async {
    if (_highScore!.value < score) {
      _pref!.put('highScore', score);
      _highScore!.value = score;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"score": score});
    }
  }

  void startBgm(String fileName) {
    if (_bgm!.value) {
      Flame.bgm.play(fileName, volume: 0.4);
    }
  }

  void pauseBgm() {
    if (_bgm!.value) {
      Flame.bgm.pause();
    }
  }

  void resumeBgm() {
    if (_bgm!.value) {
      Flame.bgm.resume();
    }
  }

  void stopBgm() {
    if (_bgm!.value) {
      Flame.bgm.stop();
    }
  }

  void playSfx(String fileName) {
    if (_sfx!.value) {
      Flame.audio.play(fileName);
    }
  }
}
