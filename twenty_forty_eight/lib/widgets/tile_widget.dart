import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final int value;

  const TileWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      decoration: BoxDecoration(
        color: _tileColor(value),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        value == 0 ? '' : '$value',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: value <= 4 ? Colors.black : Colors.white,
        ),
      ),
    );
  }

  Color _tileColor(int v) {
    switch (v) {
      case 0:
        return Colors.grey.shade300;
      case 2:
        return Colors.orange.shade100;
      case 4:
        return Colors.orange.shade200;
      case 8:
        return Colors.orange.shade300;
      case 16:
        return Colors.orange.shade400;
      case 32:
        return Colors.deepOrange.shade300;
      case 64:
        return Colors.deepOrange.shade400;
      case 128:
        return Colors.red.shade300;
      case 256:
        return Colors.red.shade400;
      case 512:
        return Colors.red.shade600;
      case 1024:
        return Colors.red.shade700;
      case 2048:
        return Colors.red.shade900;
      default:
        return Colors.black;
    }
  }
}
