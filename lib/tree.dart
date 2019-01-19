import 'package:flutter/material.dart';
import 'tree-polyomino.dart';

class Tree extends StatelessWidget {
  final double position;
  final double scale;
  final TreePolyomino tree;
  final size;

  Tree({this.position, this.scale, this.tree, this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: TreePainter(
        position: this.position,
        scale: this.scale,
        tree: this.tree,
        size: this.size,
      ),
    );
  }
}

class TreePainter extends CustomPainter {
  double position;
  double scale;
  final size;
  final TreePolyomino tree;

  TreePainter({this.position, this.tree, this.scale, this.size});

  @override
  void paint(Canvas canvas, Size size) {
    this.drawTree(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void drawTree(Canvas canvas) {
    Paint treePaint = new Paint()
      ..color = Colors.black38
      ..style = PaintingStyle.fill;

    for (Cell cell in this.tree.freeNeighbors()) {
      this.drawCell(cell, canvas, treePaint);
    }
    treePaint.color = Colors.cyan;
    for (var cell in this.tree.cells) {
      this.drawCell(cell, canvas, treePaint);
    }
  }

  List<double> scaleMove(Cell cell) {
    return [
      (cell.x*20+1 +this.position)*this.scale,
      (cell.y*20+1)*this.scale+2*size.height/3-15,
      (cell.x*20+19+this.position)*this.scale,
      (cell.y*20+19)*this.scale+2*size.height/3-15,
    ];
  }

  void drawCell(Cell cell, Canvas canvas, Paint paint) {
    var list = this.scaleMove(cell);
    var l = list[0];
    var t = list[1];
    var r = list[2];
    var b = list[3];
    canvas.drawRect(new Rect.fromLTRB(l, t, r, b), paint);
  }
}

