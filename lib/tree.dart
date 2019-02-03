import 'package:flutter/material.dart';
import 'tree-polyomino.dart';

class Tree extends StatelessWidget {
  final double position;
  final double scale;
  final TreePolyomino tree;
  final size;
  final Cell currentCell;
  final pointToScreen;
  bool visible;

  Tree({this.position, this.scale, this.tree, this.size, this.currentCell, this.pointToScreen, this.visible});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: TreePainter(
        position: this.position,
        scale: this.scale,
        tree: this.tree,
        size: this.size,
        currentCell: this.currentCell,
        pointToScreen: this.pointToScreen,
        visible: visible,
      ),
    );
  }
}

class TreePainter extends CustomPainter {
  double position;
  double scale;
  final size;
  final TreePolyomino tree;
  final Cell currentCell;
  final pointToScreen;
  bool visible;

  TreePainter({this.position, this.tree, this.scale, this.size, this.currentCell, this.pointToScreen, this.visible});

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
    for (var cell in this.tree.cells) {
      this.drawCell(cell, canvas, treePaint);
    }
    for (var cell in this.tree.rhizomes) {
      this.drawCell(cell, canvas, treePaint);
    }
    this.drawCell(currentCell, canvas, treePaint);
  }

  Offset cellToPoint(Cell cell) {
    return Offset(
        cell.x * 20.0,
        cell.y * 20.0,
      );
  }

  void drawCell(Cell cell, Canvas canvas, Paint paint) {
    Offset point = this.cellToPoint(cell);
    if (visible && cell == currentCell) {
      paint.color = Colors.white;
      canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 5), 1.0, true,), pointToScreen(point + Offset(15, 15), 1.0, true,),), paint);
      return;
    }
    switch (tree.cellType(cell)) {
      case CellType.notIn:
        paint.color = Colors.black38;
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 5), 1.0, true,), pointToScreen(point + Offset(15, 15), 1.0, true,),), paint);
        break;
      case CellType.none:
        paint.color = Colors.brown;
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 5), 1.0, true,), pointToScreen(point + Offset(15, 15), 1.0, true,),), paint);
        break;
      case CellType.full:
        paint.color = Colors.brown;
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(0, 5), 1.0, true,), pointToScreen(point + Offset(20, 15), 1.0, true,),), paint);
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 0), 1.0, true,), pointToScreen(point + Offset(15, 20), 1.0, true,),), paint);
        break;
      case CellType.leafRight:
        paint.color = Colors.green;
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 5), 1.0, true,), pointToScreen(point + Offset(20, 15), 1.0, true,),), paint);
        canvas.drawOval(Rect.fromPoints(pointToScreen(point + Offset(0, 0), 1.0, true,), pointToScreen(point + Offset(20, 20), 1.0, true,),), paint);
        break;
      case CellType.leafLeft:
        paint.color = Colors.green;
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(0, 5), 1.0, true,), pointToScreen(point + Offset(15, 15), 1.0, true,),), paint);
        canvas.drawOval(Rect.fromPoints(pointToScreen(point + Offset(0, 0), 1.0, true,), pointToScreen(point + Offset(20, 20), 1.0, true,),), paint);
        break;
      case CellType.leafUp:
        paint.color = Colors.green;
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 0), 1.0, true,), pointToScreen(point + Offset(15, 15), 1.0, true,),), paint);
        canvas.drawOval(Rect.fromPoints(pointToScreen(point + Offset(0, 0), 1.0, true,), pointToScreen(point + Offset(20, 20), 1.0, true,),), paint);
        break;
      case CellType.leafDown:
        paint.color = Colors.green;
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 5), 1.0, true,), pointToScreen(point + Offset(15, 20), 1.0, true,),), paint);
        canvas.drawOval(Rect.fromPoints(pointToScreen(point + Offset(0, 0), 1.0, true,), pointToScreen(point + Offset(20, 20), 1.0, true,),), paint);
        break;
      case CellType.horizontal:
        paint.color = Colors.brown;
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(0, 5), 1.0, true,), pointToScreen(point + Offset(20, 15), 1.0, true,),), paint);
        break;
      case CellType.vertical:
        paint.color = Colors.brown;
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 0), 1.0, true,), pointToScreen(point + Offset(15, 20), 1.0, true,),), paint);
        break;
      case CellType.teeUp:
        paint.color = Colors.brown;
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(0, 5), 1.0, true,), pointToScreen(point + Offset(20, 15), 1.0, true,),), paint);
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 5), 1.0, true,), pointToScreen(point + Offset(15, 20), 1.0, true,),), paint);
        break;
      case CellType.teeDown:
        paint.color = Colors.brown;
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(0, 5), 1.0, true,), pointToScreen(point + Offset(20, 15), 1.0, true,),), paint);
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 0), 1.0, true,), pointToScreen(point + Offset(15, 15), 1.0, true,),), paint);
        break;
      case CellType.teeRight:
        paint.color = Colors.brown;
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 0), 1.0, true,), pointToScreen(point + Offset(15, 20), 1.0, true,),), paint);
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(0, 5), 1.0, true,), pointToScreen(point + Offset(15, 15), 1.0, true,),), paint);
        break;
      case CellType.teeLeft:
        paint.color = Colors.brown;
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 0), 1.0, true,), pointToScreen(point + Offset(15, 20), 1.0, true,),), paint);
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 5), 1.0, true,), pointToScreen(point + Offset(20, 15), 1.0, true,),), paint);
        break;
      case CellType.upRight:
        paint.color = Colors.brown;
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 0), 1.0, true,), pointToScreen(point + Offset(15, 15), 1.0, true,),), paint);
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 5), 1.0, true,), pointToScreen(point + Offset(20, 15), 1.0, true,),), paint);
        break;
      case CellType.upLeft:
        paint.color = Colors.brown;
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 0), 1.0, true,), pointToScreen(point + Offset(15, 15), 1.0, true,),), paint);
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(0, 5), 1.0, true,), pointToScreen(point + Offset(15, 15), 1.0, true,),), paint);
        break;
      case CellType.downRight:
        paint.color = Colors.brown;
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 5), 1.0, true,), pointToScreen(point + Offset(20, 15), 1.0, true,),), paint);
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 5), 1.0, true,), pointToScreen(point + Offset(15, 20), 1.0, true,),), paint);
        break;
      case CellType.downLeft:
        paint.color = Colors.brown;
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(0, 5), 1.0, true,), pointToScreen(point + Offset(15, 15), 1.0, true,),), paint);
        canvas.drawRect(Rect.fromPoints(pointToScreen(point + Offset(5, 5), 1.0, true,), pointToScreen(point + Offset(15, 20), 1.0, true,),), paint);
        break;
    }
  }
}
