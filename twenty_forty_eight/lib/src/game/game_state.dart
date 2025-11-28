import 'dart:math';

class GameState {
  static const int gridSize = 4;
  late List<List<int>> board;
  int score = 0;
  bool isGameOver = false;

  GameState() {
    startGame();
  }

  void startGame() {
    board = List.generate(gridSize, (_) => List.filled(gridSize, 0));
    score = 0;
    isGameOver = false;
    _addRandomTile();
    _addRandomTile();
    _addRandomTile();
  }

  void _addRandomTile() {
    final empty = <Point<int>>[];
    for (var r = 0; r < gridSize; r++) {
      for (var c = 0; c < gridSize; c++) {
        if (board[r][c] == 0) empty.add(Point(r, c));
      }
    }
    if (empty.isEmpty) return;
    final pos = empty[Random().nextInt(empty.length)];
    board[pos.x][pos.y] = Random().nextInt(10) == 0 ? 4 : 2;
  }

  bool moveLeft() => _move((i) => board[i]);
  bool moveRight() => _move((i) => board[i].reversed.toList(), reversed: true);
  bool moveUp() => _move(
        (i) => List.generate(gridSize, (r) => board[r][i]),
        setColumn: (i, col) {
          for (int r = 0; r < gridSize; r++) board[r][i] = col[r];
        },
      );
  bool moveDown() => _move(
        (i) => List.generate(gridSize, (r) => board[r][i]).reversed.toList(),
        setColumn: (i, col) {
          for (int r = 0; r < gridSize; r++) board[r][i] = col.reversed.toList()[r];
        },
      );

  bool _move(List<int> Function(int) extractor, {bool reversed = false, void Function(int, List<int>)? setColumn}) {
    bool moved = false;
    for (int i = 0; i < gridSize; i++) {
      List<int> row = extractor(i);
      List<int> compacted = _compact(row);
      if (!_listEqual(row, compacted)) moved = true;
      if (setColumn != null) {
        setColumn(i, compacted);
      } else {
        if (reversed) compacted = compacted.reversed.toList();
        board[i] = compacted;
      }
    }
    if (moved) {
      _addRandomTile();
      _checkGameOver();
    }
    return moved;
  }

  List<int> _compact(List<int> row) {
    final filtered = row.where((e) => e != 0).toList();
    final compacted = <int>[];
    int i = 0;
    while (i < filtered.length) {
      if (i + 1 < filtered.length && filtered[i] == filtered[i + 1]) {
        int merged = filtered[i] * 2;
        score += merged;
        compacted.add(merged);
        i += 2;
      } else {
        compacted.add(filtered[i]);
        i++;
      }
    }
    while (compacted.length < gridSize) compacted.add(0);
    return compacted;
  }

  bool _listEqual(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) if (a[i] != b[i]) return false;
    return true;
  }

  void _checkGameOver() {
    for (var r = 0; r < gridSize; r++) {
      for (var c = 0; c < gridSize; c++) {
        if (board[r][c] == 0) return;
        if (r < gridSize - 1 && board[r][c] == board[r + 1][c]) return;
        if (c < gridSize - 1 && board[r][c] == board[r][c + 1]) return;
      }
    }
    isGameOver = true;
  }
}