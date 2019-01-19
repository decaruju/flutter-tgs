import 'tree-polyomino.dart';
import 'dart:math';

class GameState {
  TreePolyomino tree;
  _Resources resources;
  BigInt time;

  GameState({this.tree}) {
    this.resources = _Resources();
    this.time = BigInt.from(0);
  }

  void addResources() {
    this.resources.sun += tree.numberOfLeaves / 50 * sunlight;
    this.resources.water += tree.numberOfRoots / 100;
  }

  void useResources() {
    this.resources.sun -= tree.cells.length / 400;
    this.resources.water -= tree.cells.length / 200 * sunlight;
  }

  bool canBuild(Cell cell) {
    return cell.y != 0 &&
        !tree.contains(cell) &&
        tree.degree(cell) == 1 &&
        resources.sun > 10 &&
        resources.water > 10;
  }

  void killCell() {
    if (this.resources.sun <= 0) {
      if (this.tree.killRoot()) {
        this.resources.sun += 10;
      } else {
        this.resources.sun = 0;
      }
    }
    if (this.resources.water <= 0) {
      if (this.tree.killLeaf()) {
        this.resources.water += 10;
      } else {
        this.resources.water = 0;
      }
    }
  }

  void tick() {
    this.addResources();
    this.useResources();
    this.time += BigInt.from(1);
    if (this.resources.empty) {
      this.killCell();
    }
  }

  double get angle {
    return (this.time % BigInt.from(1000)).toDouble() / 1000 * 2 * pi + pi / 2;
  }

  double get sunlight {
    return between(cos(this.angle - pi) * 0.7 + 0.5, 0, 1);
  }

  void buildCell(cell) {
    tree.add(cell);
    this.resources.sun -= 10;
    this.resources.water -= 10;
  }
}

class _Resources {
  double sun;
  double water;

  _Resources() {
    this.sun = 10;
    this.water = 10;
  }

  bool get empty {
    return this.sun <= 0 || this.water <= 0;
  }

  String toString() {
    return "${this.sun}, ${this.water}";
  }
}

double between(double value, double min, double max) {
  if (value < min) {
    value = min;
  }
  if (value > max) {
    value = max;
  }
  return value;
}
