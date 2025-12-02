import 'package:flutter/material.dart';

class ControlsWidget extends StatelessWidget {
  final VoidCallback onRestart;
  final VoidCallback onQuit;

  const ControlsWidget({
    super.key,
    required this.onRestart,
    required this.onQuit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: onRestart,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text('Restart'),
        ),
        ElevatedButton(
          onPressed: onQuit,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text('Quit'),
        ),
      ],
    );
  }
}
