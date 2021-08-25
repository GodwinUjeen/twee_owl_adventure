import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twee_owl_adventure/Widgets/exit_dialog.dart';

class PauseMenu extends StatelessWidget {
  final Function onResumePressed;
  final Function onRestartGame;

  const PauseMenu(
      {Key? key, required this.onResumePressed, required this.onRestartGame})
      : super(key: key);

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Resume',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black87,
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
                        onResumePressed.call();
                      },
                      icon: Icon(
                        Icons.play_circle_outline_rounded,
                        size: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Restart',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black87,
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
                        // color: Color.fromRGBO(252, 61, 3, 1),
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
                        onRestartGame.call();
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
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Exit',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black87,
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
        ),
      ),
    );
  }
}
