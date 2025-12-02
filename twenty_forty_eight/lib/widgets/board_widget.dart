import 'package:flutter/material.dart';
import '../models/game_state.dart';
import 'tile_widget.dart';

class BoardWidget extends StatelessWidget {
  final GameState gameState;

  const BoardWidget({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFBBADA0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            for (int row = 0; row < GameState.gridSize; row++)
              Expanded(
                child: Row(
                  children: [
                    for (int col = 0; col < GameState.gridSize; col++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TileWidget(value: gameState.board[row][col]),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
