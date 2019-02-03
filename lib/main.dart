import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'world.dart';
import 'game-state.dart';
import 'tree-polyomino.dart';
import 'mouseover.dart';
import 'package:flutter/rendering.dart';
import 'ui.dart';
import 'menu/about.dart';
import 'menu/stats.dart';
import 'menubar.dart';
import 'package:flutter/services.dart';

void main() {
  // debugPaintSizeEnabled = true;31
  SystemChrome.setEnabledSystemUIOverlays([]);
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
  List menus;

  @override
  void initState() {
    super.initState();
    this.gameState = GameState(tree: TreePolyomino());
    world = World(seed: widget.seed, gameState: gameState);
    timer = new Timer.periodic(const Duration(milliseconds: 10), tick);
    menus = [
      Offstage(),
      Stats(),
      About(),
    ];
  }

  void tick(Timer timer) {
    setState(() {
      this.gameState.tick();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          world,
          UI(gameState: gameState),
          Container(
            width: size.width,
            height: size.height*2/3.0,
            alignment: Alignment(0, 1.0),
            child: menus[gameState.menu],
          ),
          MenuBar(gameState: gameState),
        ],
      ),
    );
  }
}
