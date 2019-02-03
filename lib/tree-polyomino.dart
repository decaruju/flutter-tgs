import 'dart:math';

enum CellType {
  none, leafUp, leafRight, leafLeft, leafDown, horizontal, vertical, teeUp, teeRight, teeLeft, teeDown, upRight, upLeft, downRight, downLeft, full, notIn
}

class Cell {
  int x;
  int y;

  static List<Cell> directions = [Cell(x: 0, y: 1), Cell(x: 0, y: -1), Cell(x: 1, y: 0), Cell(x: -1, y: 0)];

  Cell({this.x, this.y});

  int get hashCode {
    return [x, y].hashCode;
  }

  bool operator ==(rhs) {
    return this.x == rhs.x && this.y == rhs.y;
  }

  Cell operator +(rhs) {
    return Cell(
      x: this.x + rhs.x,
      y: this.y + rhs.y
    );
  }

  List<Cell> neighbors() {
    return directions.map((Cell c) => this + c).toList();
  }

  String toString() {
    return 'Cell(x: ' + this.x.toString() + ', y: ' + this.y.toString() + ')';
  }
}

class TreePolyomino{
  List<Cell> cells;
  List<Cell> rhizomes;
  static final Random _random = new Random();

  TreePolyomino() {
    this.cells = List<Cell>();
    this.rhizomes = List<Cell>();
    this.cells.add(Cell(x: 0, y: 0));
  }

  List<Cell> get allCells {
    return cells + rhizomes;
  }

  CellType cellType(Cell c) {
    if (!allCells.contains(c)) return CellType.notIn;
    if (degree(c) == 0) return CellType.none;
    if (degree(c) == 4) return CellType.full;
    if (degree(c) == 1) {
      if (allCells.contains(Cell(x: c.x+1, y: c.y+0))) return CellType.leafRight;
      if (allCells.contains(Cell(x: c.x-1, y: c.y+0))) return CellType.leafLeft;
      if (allCells.contains(Cell(x: c.x+0, y: c.y+1))) return CellType.leafDown;
      if (allCells.contains(Cell(x: c.x+0, y: c.y-1))) return CellType.leafUp;
    }
    if (degree(c) == 2) {
      if (allCells.contains(Cell(x: c.x+1, y: c.y+0))) {
        if (allCells.contains(Cell(x: c.x-1, y: c.y+0))) return CellType.horizontal;
        if (allCells.contains(Cell(x: c.x+0, y: c.y+1))) return CellType.downRight;
        if (allCells.contains(Cell(x: c.x+0, y: c.y-1))) return CellType.upRight;
      }
      if (allCells.contains(Cell(x: c.x-1, y: c.y+0))) {
        if (allCells.contains(Cell(x: c.x+0, y: c.y+1))) return CellType.downLeft;
        if (allCells.contains(Cell(x: c.x+0, y: c.y-1))) return CellType.upLeft;
      }
      return CellType.vertical;
    }
    if (degree(c) == 3) {
      if (!allCells.contains(Cell(x: c.x+1, y: c.y+0))) return CellType.teeRight;
      if (!allCells.contains(Cell(x: c.x-1, y: c.y+0))) return CellType.teeLeft;
      if (!allCells.contains(Cell(x: c.x+0, y: c.y+1))) return CellType.teeDown;
      if (!allCells.contains(Cell(x: c.x+0, y: c.y-1))) return CellType.teeUp;
    }
    return CellType.full;

  }

  int degree(Cell c) {
    return c.neighbors().map((c) => allCells.contains(c) ? 1 : 0).reduce((elem, total) => elem + total);
  }

  bool contains(Cell c) {
    return allCells.contains(c);
  }

  void addRhizome(Cell c) {
    cells.remove(c);
    rhizomes.add(c);
  }

  void add(Cell c) {
    if (degree(c) == 1 && c.y != 0 && !cells.contains(c)) {
      cells.add(c);
    }
  }


  int get numberOfLeaves {
    return cells.map((cell) => (cell.y <= 0 && degree(cell) <= 1 ? 1 : 0)).reduce((total, elem) => total + elem);
  }

  int get numberOfRoots {
    return cells.map((cell) => (cell.y >= 0 && degree(cell) <= 1 ? 1 : 0)).reduce((total, elem) => total + elem);
  }

  List<Cell> freeNeighbors() {
    List<Cell> rtn = List<Cell>();
    for (Cell cell in cells) {
      for (Cell otherCell in cell.neighbors()) {
        if (degree(otherCell) == 1 && otherCell.y != 0) {
          if (rhizomes.length == 0) {
            if (!rtn.contains(otherCell)) {
              rtn.add(otherCell);
            }
          }
          if (all(rhizomes, (rhizome) => otherCell.y > rhizome.y || (otherCell.x - rhizome.x).abs() > 1)) {
            rtn.add(otherCell);
          }
        }
      }
    }
    return rtn;
  }

  int randomCell() {
    return _random.nextInt(this.cells.length);
  }

  bool killLeaf() {
    if (filter(this.cells, (cell) => cell.y < 0).length == 0) {
      return false;
    }
    Cell cell;
    int i;
    do {
      i = this.randomCell();
      cell = this.cells[i];
    } while (degree(cell) != 1 || cell.y >= 0);
    this.cells.removeAt(i);
    return true;
  }

  bool killRoot() {
    if (filter(this.cells, (cell) => cell.y > 0).length == 0) {
      return false;
    }
    if (this.rhizomes.length > 0) {
      this.rhizomes.clear();
      return true;
    }
    Cell cell;
    int i;
    do {
      i = this.randomCell();
      cell = this.cells[i];
    } while (degree(cell) != 1 || cell.y <= 0);
    this.cells.removeAt(i);
    return true;
  }
}

bool all(collection, function) {
  for (var elem in collection) {
    if (!function(elem)) {
      return false;
    }
  }
  return true;
}

List<Cell> filter(collection, function) {
  List<Cell> rtn = [];
  for (Cell cell in collection) {
    if (function(cell)) {
      rtn.add(cell);
    }
  }
  return rtn;
}
