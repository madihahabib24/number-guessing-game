import 'package:flutter/material.dart';
import 'game_screen.dart';
import 'history_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Guessing Game'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.games, size: 90, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Number Guessing Game!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameScreen()),
                );
              },
              child: const Text('Start Game'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HistoryScreen(),
                  ),
                );
              },
              child: const Text('View History'),
            ),
          ],
        ),
      ),
    );
  }
}
