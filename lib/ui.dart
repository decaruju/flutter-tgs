import 'package:flutter/material.dart';
import 'mouseover.dart';

class UI extends StatelessWidget {
  final gameState;

  UI({this.gameState});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(1.0, -1.0),
      child: Container(
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "⊠ ${gameState.tree.cells.length}",
                    style: TextStyle(
                      color: Colors.white,
                    )
                  ),
                ),
                Expanded(
                  child: Text(
                    "🍃 ${gameState.tree.numberOfLeaves}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "⸙ ${gameState.tree.numberOfRoots}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "☀ ${gameState.resources.sun.toInt()}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "🌊 ${gameState.resources.water.toInt()}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Mouseover(
              visible: this.gameState.mouseOverVisible,
              confirmCallback: () {this.gameState.mouseOverVisible = false; this.gameState.buildCell(this.gameState.currentCell);},
              cancelCallback: () {this.gameState.mouseOverVisible = false;},
              text: this.gameState.mouseOverText
            ),
          ],
        ),
      ),
    );
  }
}
