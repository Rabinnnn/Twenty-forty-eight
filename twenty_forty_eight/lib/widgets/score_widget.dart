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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Game name on top-left
          const Text(
            '2048',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF776E65),
            ),
          ),

          // Score boxes on top-right
          Row(
            children: [
              _buildScoreBox('Score', currentScore),
              const SizedBox(width: 8),
              _buildScoreBox('Best', bestScore),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreBox(String label, int value) {
    return Container(
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
