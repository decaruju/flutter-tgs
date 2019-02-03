import 'package:flutter/material.dart';

class MenuBar extends StatelessWidget {
  final gameState;

  MenuBar({this.gameState});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(1.0, 1.0),
      child: Container(
        color: Colors.black,
        child: Row(
          children: <Widget>[
            MenuBarButton(
              text: "Stats",
              callback: () {gameState.openMenu(1);}
            ),
            MenuBarButton(
              text: "About",
              callback: () {gameState.openMenu(2);}
            ),
          ],
        ),
      ),
    );
  }
}


class MenuBarButton extends StatelessWidget {
  final callback;
  final text;

  MenuBarButton({this.callback, this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        onPressed: callback,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          )
        ),
      ),
    );
  }
}
