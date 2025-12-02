import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  final int currentScore;
  final int bestScore;

  const ScoreWidget({
    super.key,
    required this.currentScore,
    required this.bestScore,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildScoreBox('Score', currentScore),
        _buildScoreBox('Best', bestScore),
      ],
    );
  }

  Widget _buildScoreBox(String label, int value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFBBADA0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
