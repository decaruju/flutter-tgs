import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'world.dart';
import 'game-state.dart';
import 'tree-polyomino.dart';
import 'mouseover.dart';
import 'package:flutter/rendering.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final seed = new Random().nextInt(1000000000);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(seed: this.seed),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final seed;
  MyHomePage({Key key, this.seed}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer timer;
  GameState gameState;
  World world;

  @override
  void initState() {
    super.initState();
    this.gameState = GameState(tree: TreePolyomino());
    world = World(seed: widget.seed, gameState: gameState);
    timer = new Timer.periodic(const Duration(milliseconds: 10), tick);
  }

  void tick(Timer timer) {
    setState(() {
      this.gameState.tick();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: <Widget>[
          world,
          Align(
            alignment: Alignment(1.0, 1.0),
            child: Container(
              color: Colors.black,
              child: Row(
                children: <Widget>[
                  Text(
                    "Size: ${gameState.tree.cells.length}",
                    style: TextStyle(
                      color: Colors.white,
                    )
                  ),
                  Text(
                    "Leaves: ${gameState.tree.numberOfLeaves}",
                    style: TextStyle(
                      color: Colors.white,
                    )
                  ),
                  Text(
                    "Roots: ${gameState.tree.numberOfRoots}",
                    style: TextStyle(
                      color: Colors.white,
                    )
                  ),
                  Text(
                    "Sun: ${gameState.resources.sun.toInt()}",
                    style: TextStyle(
                      color: Colors.white,
                    )
                  ),
                  Text(
                    "Water: ${gameState.resources.water.toInt()}",
                    style: TextStyle(
                      color: Colors.white,
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
