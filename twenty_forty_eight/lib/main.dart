import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(const TwentyFortyEightApp());
}

class TwentyFortyEightApp extends StatelessWidget {
  const TwentyFortyEightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '2048 (Early Release)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const GameScreen(),
    );
  }
}
