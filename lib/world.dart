import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';
import 'world/star-box.dart';
import 'world/ground.dart';
import 'world/sky.dart';
import 'world/sun.dart';
import 'world/moon.dart';
import 'tree.dart';
import 'tree-polyomino.dart';
import 'game-state.dart';
import 'mouseover.dart';
import 'dart:async';


class World extends StatefulWidget {
  final int seed;
  final GameState gameState;

  World({this.seed, this.gameState});

  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> {
  double position;
  double zoom;
  double lastZoom;
  Cell currentCell;
  bool visible;
  TreePolyomino tree;
  Timer timer;
  Text text;
  var size;

  @override
  void initState() {
    super.initState();
    position = 0.0;
    zoom = 1.0;
    currentCell = Cell(x: 0, y: 0);
    visible = false;
    tree = widget.gameState.tree;
    timer = new Timer.periodic(const Duration(milliseconds: 15), (Timer timer) => setState(() {}));
    text = Text('');
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      position += details.delta.dx/this.zoom;
    });
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      // zoom *= details.scale/lastZoom;
      // lastZoom = details.scale;
      // position -= 1-details.scale/lastZoom;
    });
  }

  void onScaleStart(ScaleStartDetails details) {
    setState(() {
      //lastZoom = 1.0;
    });
  }

  void onTapUp(TapUpDetails details) {
    Cell cell = Cell(
      x: ((details.globalPosition.dx - position)/20).floor(),
      y: ((details.globalPosition.dy - 2*size.height/3 +15)/20).floor()
    );

    if (widget.gameState.tree.contains(cell) && widget.gameState.tree.degree(cell) == 1) {
      if (cell.y > 0 && widget.gameState.canRhyzome(cell)) {
        this.text = Text('Confirm transforming this root into a rhyzome ?');
        currentCell = cell;
        visible = true;
      } else if (cell.y < 0) {
        this.text = Text('Confirm transforming this leaf into a flower ?');
        currentCell = cell;
        visible = true;
      }
    }
    if (cell == currentCell && visible == true) {
      widget.gameState.buildCell(cell);
      visible = false;
    } else if (widget.gameState.canBuild(cell)) {
      setState(() {
        currentCell = cell;
        visible = true;
        this.text = Text('Confirm building this cell for 10 sun and 10 water ?');
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    this.size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        GestureDetector(
          onHorizontalDragUpdate: onHorizontalDragUpdate,
          onScaleUpdate: onScaleUpdate,
          onScaleStart: onScaleStart,
          onTapUp: onTapUp,
          child: Container(
            color: Colors.black,
            height: size.height,
            width: size.width,
            child: Stack(
              children: <Widget>[
                StarBox(
                  angle: widget.gameState.angle,
                  size: size,
                  seed: widget.seed,
                ),
                Moon(
                  angle: widget.gameState.angle,
                  size: size,
                ),
                Sky(
                  sunlight: widget.gameState.sunlight,
                  size: size,
                ),
                Sun(
                  angle: widget.gameState.angle,
                  size: size,
                ),
                Ground(
                  size: size,
                  position: this.position,
                ),
                Tree(
                  position: this.position,
                  scale: this.zoom,
                  tree: this.tree,
                  size: size,
                ),
              ],
            )
          ),
        ),
        Mouseover(
          visible: this.visible,
          position: position,
          text: this.text,
          offset: Offset(currentCell.x.toDouble()*20, currentCell.y.toDouble()*20 + (size.height*2/3).toInt()),
          confirmCallback: () {this.visible = false; widget.gameState.buildCell(currentCell);},
          cancelCallback: () {this.visible = false;},
        ),
      ]
    );
  }
}
