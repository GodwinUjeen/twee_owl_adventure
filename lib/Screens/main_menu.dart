import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twee_owl_adventure/Widgets/menu.dart';
import 'package:twee_owl_adventure/Widgets/settings.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  ValueNotifier<CrossFadeState>? _crossFadeStateNotifier;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _crossFadeStateNotifier = ValueNotifier(CrossFadeState.showFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            color: Colors.transparent,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 40.0),
              child: ValueListenableBuilder(
                valueListenable: _crossFadeStateNotifier!,
                builder: (BuildContext context, CrossFadeState value,
                    Widget? child) {
                  return AnimatedCrossFade(
                    crossFadeState: value,
                    duration: Duration(milliseconds: 300),
                    firstChild: Menu(
                      onSettingsPressed: showSettings,
                    ),
                    secondChild: Settings(
                      onBackPressed: showMenu,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showMenu() {
    _crossFadeStateNotifier!.value = CrossFadeState.showFirst;
  }

  void showSettings() {
    _crossFadeStateNotifier!.value = CrossFadeState.showSecond;
  }
}
