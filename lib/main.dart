import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:twee_owl_adventure/Screens/SplashScreen.dart';
import 'package:twee_owl_adventure/Services/FirebaseServices.dart';
import 'package:twee_owl_adventure/Widgets/exit_dialog.dart';
import 'package:twee_owl_adventure/game/audio_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Flame.util.fullScreen();
  await Flame.util.setLandscape();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  AudioManager.instance.init([
    '8Bit Platformer Loop.wav',
    'hurt.wav',
    'jump.wav',
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExitDialog()),
        ChangeNotifierProvider(create: (_) => FirebaseServices()),
      ],
      child: MaterialApp(
        title: 'Twee Owl Adventure',
        theme: ThemeData(
          fontFamily: 'Audiowide',
          primarySwatch: Colors.lightGreen,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
