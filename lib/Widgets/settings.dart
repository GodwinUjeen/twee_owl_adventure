import 'package:flutter/material.dart';
import 'package:twee_owl_adventure/game/audio_manager.dart';

class Settings extends StatelessWidget {
  final Function onBackPressed;

  const Settings({Key? key, required this.onBackPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Settings',
            style: TextStyle(fontSize: 40.0, color: Colors.white),
          ),
          SizedBox(
            height: 10.0,
          ),
          ValueListenableBuilder(
            valueListenable: AudioManager.instance.listenableSfx!,
            builder: (BuildContext context, bool isSfxOn, Widget? child) {
              return SwitchListTile(
                value: isSfxOn,
                title: Text(
                  'SFX',
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
                onChanged: (bool value) {
                  AudioManager.instance.setSfx(value);
                },
              );
            },
          ),
          ValueListenableBuilder(
              valueListenable: AudioManager.instance.listenableBgm!,
              builder: (BuildContext context, bool isBgmOn, Widget? child) {
                return SwitchListTile(
                  value: isBgmOn,
                  title: Text(
                    'BGM',
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                  onChanged: (bool value) {
                    AudioManager.instance.setBgm(value);
                  },
                );
              }),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.lightGreenAccent,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    onBackPressed();
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
