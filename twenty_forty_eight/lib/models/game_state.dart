import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

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
    List<Point<int>> empty = [];

    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        if (board[r][c] == 0) empty.add(Point(r, c));
      }
    }

    if (empty.isEmpty) return;
    final pos = empty[Random().nextInt(empty.length)];
    board[pos.x][pos.y] = Random().nextDouble() < 0.9 ? 2 : 4;
  }

  void move(String direction) {
    bool moved = false;

    List<List<int>> original =
        board.map((row) => List<int>.from(row)).toList();

    switch (direction) {
      case 'up':
        for (int c = 0; c < gridSize; c++) moved |= _compressColumn(c);
        break;

      case 'down':
        for (int c = 0; c < gridSize; c++) moved |= _compressColumn(c, reverse: true);
        break;

      case 'left':
        for (int r = 0; r < gridSize; r++) moved |= _compressRow(r);
        break;

      case 'right':
        for (int r = 0; r < gridSize; r++) moved |= _compressRow(r, reverse: true);
        break;
    }

    if (moved) _addRandomTile();
    _checkGameOver();

    if (isGameOver) _saveBestScore();
  }

  bool _compressRow(int r, {bool reverse = false}) {
    List<int> row = board[r];
    if (reverse) row = List.from(row.reversed);

    List<int> filtered = row.where((n) => n != 0).toList();

    for (int i = 0; i < filtered.length - 1; i++) {
      if (filtered[i] == filtered[i + 1]) {
        filtered[i] *= 2;
        score += filtered[i];
        filtered[i + 1] = 0;
      }
    }

    filtered = filtered.where((n) => n != 0).toList();
    while (filtered.length < gridSize) filtered.add(0);

    if (reverse) filtered = List.from(filtered.reversed);

    bool changed = !_listsEqual(board[r], filtered);
    board[r] = filtered;
    return changed;
  }

  bool _compressColumn(int c, {bool reverse = false}) {
    List<int> col = [for (int r = 0; r < gridSize; r++) board[r][c]];
    if (reverse) col = List.from(col.reversed);

    List<int> filtered = col.where((n) => n != 0).toList();

    for (int i = 0; i < filtered.length - 1; i++) {
      if (filtered[i] == filtered[i + 1]) {
        filtered[i] *= 2;
        score += filtered[i];
        filtered[i + 1] = 0;
      }
    }

    filtered = filtered.where((n) => n != 0).toList();
    while (filtered.length < gridSize) filtered.add(0);

    if (reverse) filtered = List.from(filtered.reversed);

    bool changed = false;
    for (int r = 0; r < gridSize; r++) {
      if (board[r][c] != filtered[r]) changed = true;
      board[r][c] = filtered[r];
    }

    return changed;
  }

  void _checkGameOver() {
    for (var row in board) {
      if (row.contains(0)) {
        isGameOver = false;
        return;
      }
    }

    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        int v = board[r][c];
        if (r < gridSize - 1 && board[r + 1][c] == v) return;
        if (c < gridSize - 1 && board[r][c + 1] == v) return;
      }
    }

    isGameOver = true;
  }

  bool _listsEqual(List a, List b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  Future<void> _saveBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    int best = prefs.getInt('bestScore') ?? 0;
    if (score > best) {
      await prefs.setInt('bestScore', score);
    }
  }

  static Future<int> loadBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('bestScore') ?? 0;
  }
}
