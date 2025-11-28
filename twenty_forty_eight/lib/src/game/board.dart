import 'package:flutter/material.dart';
import 'tile.dart';
import '../game/game_state.dart';

class BoardWidget extends StatelessWidget {
  final GameState game;
  const BoardWidget({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(12),
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: GameState.gridSize * GameState.gridSize,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: GameState.gridSize,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            int r = index ~/ GameState.gridSize;
            int c = index % GameState.gridSize;
            int value = game.board[r][c];
            return TileWidget(value: value);
          },
        ),
      ),
    );
  }
}
