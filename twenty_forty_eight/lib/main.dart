import 'package:flutter/material.dart';
import 'src/game/board.dart';
import 'src/game/game_state.dart';

void main() {
  runApp(const Game2048App());
}

class Game2048App extends StatelessWidget {
  const Game2048App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '2048 Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameState game;

  @override
  void initState() {
    super.initState();
    game = GameState();
    game.startGame();
  }

  void handleSwipe(DragEndDetails details) {
    final velocity = details.primaryVelocity;
    if (velocity == null) return;

    if (details.velocity.pixelsPerSecond.dx.abs() >
        details.velocity.pixelsPerSecond.dy.abs()) {
      if (velocity > 0) {
        setState(() => game.moveRight());
      } else {
        setState(() => game.moveLeft());
      }
    } else {
      if (velocity > 0) {
        setState(() => game.moveDown());
      } else {
        setState(() => game.moveUp());
      }
    }

    if (game.isGameOver) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Game Over"),
          content: Text("Score: ${game.score}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() => game.startGame());
              },
              child: const Text("Restart"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("2048"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() => game.startGame()),
          )
        ],
      ),
      body: GestureDetector(
        onHorizontalDragEnd: handleSwipe,
        onVerticalDragEnd: handleSwipe,
        child: Center(
          child: BoardWidget(game: game),
        ),
      ),
    );
  }
}
