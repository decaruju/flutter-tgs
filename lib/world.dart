import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';
import 'world/star-box.dart';
import 'world/ground.dart';
import 'world/landscape.dart';
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
  bool visible;
  TreePolyomino tree;
  Timer timer;
  var size;

  @override
  void initState() {
    super.initState();
    position = 0.0;
    zoom = 1.0;
    visible = false;
    tree = widget.gameState.tree;
    timer = new Timer.periodic(const Duration(milliseconds: 15), (Timer timer) => setState(() {}));
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      position += details.delta.dx/this.zoom;
    });
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      zoom *= details.scale/lastZoom;
      position += details.focalPoint.dx*(1-details.scale/lastZoom);
      lastZoom = details.scale;
    });
  }


  void onScaleStart(ScaleStartDetails details) {
    setState(() {
      lastZoom = 1.0;
    });
  }

  void onTapUp(TapUpDetails details) {
    Cell cell = Cell(
      x: ((details.globalPosition.dx - position)/(20*zoom)).floor(),
      y: ((details.globalPosition.dy + 20*this.zoom/2 - 2*size.height/3.0)/(20*zoom)).floor()
    );

    if (widget.gameState.tree.contains(cell) && widget.gameState.tree.degree(cell) == 1) {
      if (cell.y > 0 && widget.gameState.canRhizome(cell)) {
        widget.gameState.mouseOverText = 'Confirm transforming this root into a rhizome ?';
        widget.gameState.currentCell = cell;
        widget.gameState.mouseOverVisible = true;
      } else if (cell.y < 0) {
        widget.gameState.mouseOverText = 'Confirm transforming this leaf into a flower ?';
        widget.gameState.currentCell = cell;
        widget.gameState.mouseOverVisible = true;
      }
    }
    if (cell == widget.gameState.currentCell && widget.gameState.mouseOverVisible == true) {
      widget.gameState.buildCell(cell);
      widget.gameState.mouseOverVisible = false;
    } else if (widget.gameState.canBuild(cell)) {
      setState(() {
        widget.gameState.currentCell = cell;
        widget.gameState.mouseOverVisible = true;
        widget.gameState.mouseOverText = Confirm building this cell for 10 sun and 10 water ?';
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    this.size = MediaQuery.of(context).size;
    final pointToScreen = (Offset point, double depth, bool zoom) => Offset(
      point.dx*(zoom ? this.zoom : 1) + this.position/depth,
      (point.dy)*(zoom ? this.zoom : 1) + size.height*2/3.0 - 20*(zoom ? this.zoom : 1)/2,
    );
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
                Landscape(
                  size: size,
                  position: this.position,
                  pointToScreen: pointToScreen,
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
                  currentCell: widget.gameState.currentCell,
                  visible: visible,
                  pointToScreen: pointToScreen,
                ),
              ],
            )
          ),
        ),
      ]
    );
  }
}
