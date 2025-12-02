import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/game_state.dart';
import '../widgets/board_widget.dart';
import '../widgets/score_widget.dart';
import '../widgets/controls_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameState _gameState;
  int _bestScore = 0;
  bool _showInstructions = true;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() async {
    _bestScore = await GameState.loadBestScore();
    _gameState = GameState();
    setState(() {});
  }

  void _restartGame() {
    setState(() {
      _gameState = GameState();
      // _showInstructions = true;
    });
  }

  void _quitGame() {
    // Navigator.pop(context);
    SystemNavigator.pop();
  }

  void _handleSwipe(String direction) async {
    setState(() {
      _gameState.move(direction);
    });

    // Update best score only if game is over
    if (_gameState.isGameOver) {
      if (_gameState.score > _bestScore) {
        _bestScore = _gameState.score;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('bestScore', _bestScore);
      }
    }
  }

  void _startGame() {
    setState(() {
      _showInstructions = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8EF),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                ScoreWidget(currentScore: _gameState.score, bestScore: _bestScore),
                const SizedBox(height: 16),
                Expanded(
                  child: GestureDetector(
                    onVerticalDragEnd: (details) {
                      if (details.primaryVelocity! < 0) {
                        _handleSwipe('up');
                      } else {
                        _handleSwipe('down');
                      }
                    },
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity! < 0) {
                        _handleSwipe('left');
                      } else {
                        _handleSwipe('right');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: BoardWidget(gameState: _gameState),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ControlsWidget(onRestart: _restartGame, onQuit: _quitGame),
                const SizedBox(height: 16),
              ],
            ),
            if (_showInstructions)
              Container(
                color: Colors.black54,
                child: Center(
                  child: Card(
                    margin: const EdgeInsets.all(20),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('HOW TO PLAY', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          const Text(
                            'Swipe in any direction to move tiles. Matching tiles merge and increase your score. The goal is to reach 2048!',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(onPressed: _startGame, child: const Text('Start Game')),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
