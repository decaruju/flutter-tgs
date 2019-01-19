import 'dart:math';

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
  static final Random _random = new Random();

  TreePolyomino() {
    this.cells = List<Cell>();
    this.cells.add(Cell(x: 0, y: 0));
  }

  int degree(Cell c) {
    return c.neighbors().map((c) => cells.contains(c) ? 1 : 0).reduce((elem, total) => elem + total);
  }

  bool contains(Cell c) {
    return cells.contains(c);
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
          rtn.add(otherCell);
        }
      }
    }
    return rtn;
  }

  int randomCell() {
    return _random.nextInt(this.cells.length);

  }

  bool killLeaf() {
    if (this.numberOfLeaves == 1) {
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
    if (this.numberOfRoots == 1) {
      return false;
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