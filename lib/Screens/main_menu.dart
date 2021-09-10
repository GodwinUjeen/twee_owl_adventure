import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:twee_owl_adventure/Screens/AccountSettings.dart';
import 'package:twee_owl_adventure/Screens/LeaderBoardScreen.dart';
import 'package:twee_owl_adventure/Services/FirebaseServices.dart';
import 'package:twee_owl_adventure/Widgets/menu.dart';
import 'package:twee_owl_adventure/Widgets/settings.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  ValueNotifier<CrossFadeState>? _crossFadeStateNotifier;
  final User? user = FirebaseAuth.instance.currentUser;
  String? link;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _crossFadeStateNotifier = ValueNotifier(CrossFadeState.showFirst);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreenAccent,
        elevation: 2.0,
        onPressed: () async {
          var link = await Provider.of<FirebaseServices>(context, listen: false)
              .getLink();
          Share.share(link!);
        },
        splashColor: Colors.transparent,
        child: Icon(
          Icons.share,
          color: Colors.black,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 40.0),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 40, 20, 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: LeaderBoardScreen(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.5,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: AccountSettings(),
                              type: PageTransitionType.fade,
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          backgroundImage: user!.photoURL != null
                              ? NetworkImage(
                                  user.photoURL!,
                                )
                              : null,
                          child: user.photoURL == null
                              ? Center(
                                  child: Text(
                                    user.displayName![0].toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                )
                              : Container(
                                  width: 0,
                                  height: 0,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        height: 40,
                        width: 40,
                        color: Colors.transparent,
                        child: Image.asset('assets/images/podium-3.png')),
                    Container(
                      height: 50,
                      width: 60,
                      color: Colors.transparent,
                      child: Text(
                        'Leaderboard',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
