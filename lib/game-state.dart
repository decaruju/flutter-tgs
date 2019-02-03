import 'tree-polyomino.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class GameState {
  TreePolyomino tree;
  _Resources resources;
  BigInt time;
  Cell currentCell;
  int menu;
  string mouseOverText;
  bool mouseOverVisible;

  GameState({this.tree}) {
    this.resources = _Resources();
    this.time = BigInt.from(0);
    this.menu = 0;
    this.currentCell = Cell(x: 0, y: 0);
    this.mouseOverText = '';
    this.mouseOverVisible = false;
  }

  void openMenu(int i) {
    if (i == this.menu) {
      this.menu = 0;
    } else {
      this.menu = i;
    }
  }

  void addResources() {
    this.resources.sun += tree.numberOfLeaves / 50 * sunlight;
    this.resources.water += tree.numberOfRoots / 100;
  }

  void useResources() {
    this.resources.sun -= tree.cells.length / 400;
    this.resources.water -= tree.cells.length / 200 * sunlight;
  }

  bool canRhizome(Cell cell) {
    for (int y=0; y<cell.y; y++) {
      for (int x=cell.x-1; x<cell.x + 2; x++) {
        if (tree.contains(Cell(x: x, y: y))) {
          return false;
        }
      }
    }
    return true;
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

  void growRhizomes() {
    List<Cell> toAdd = [];
    for (Cell cell in tree.rhizomes) {
      this.resources.sun -= 10;
      this.resources.water -= 10;
      tree.cells.add(cell);
      if (cell.y > 0) {
        toAdd.add(Cell(x: cell.x, y: cell.y - 1));
      }
    }
    tree.rhizomes.clear();
    for (Cell cell in toAdd) {
      tree.rhizomes.add(cell);
    }
  }

  void tick() {
    this.addResources();
    this.useResources();
    if (this.time % BigInt.from(100) == BigInt.from(0)) {
      growRhizomes();
    }
    this.time += BigInt.from(1);
    if (this.resources.empty) {
      this.killCell();
    }
  }

  double get angle {
    return (this.time % BigInt.from(10000)).toDouble() / 10000 * 2 * pi + pi / 2;
  }

  double get sunlight {
    return between(cos(this.angle - pi) * 0.7 + 0.5, 0, 1);
  }

  void buildCell(Cell cell) {
    if (tree.contains(cell)) {
      if (cell.y > 0) {
        tree.addRhizome(cell);
      } else if (cell.y < 0) {
      }
    } else {
      tree.add(cell);
      this.resources.sun -= 10;
      this.resources.water -= 10;
    }
  }
}

class _Resources {
  double sun;
  double water;

  _Resources() {
    this.sun = 10000;
    this.water = 10000;
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

