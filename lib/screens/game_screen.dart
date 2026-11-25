import 'dart:math';
import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final DatabaseHelper db = DatabaseHelper();
  final TextEditingController controller = TextEditingController();

  int secretNumber = Random().nextInt(10) + 1;
  int attempts = 0;
  String message = 'Guess a number between 1 and 10';

  Future<void> checkGuess() async {
    int? guess = int.tryParse(controller.text);

    if (guess == null || guess < 1 || guess > 10) {
      setState(() {
        message = 'Enter a number from 1 to 10';
      });
      return;
    }

    String result;

    if (guess == secretNumber) {
      result = 'Correct';
    } else if (guess < secretNumber) {
      result = 'Too Low';
    } else {
      result = 'Too High';
    }

    setState(() {
      attempts++;
      message = result == 'Correct'
          ? 'Congratulations! Correct Guess!'
          : result == 'Too Low'
          ? 'Too Low! Try Again.'
          : 'Too High! Try Again.';
    });

    controller.clear();

    try {
      await db.insertHistory(guess, result);
    } catch (e) {
      debugPrint('History error: $e');
    }
  }

  void restartGame() {
    setState(() {
      secretNumber = Random().nextInt(10) + 1;
      attempts = 0;
      message = 'Guess a number between 1 and 10';
      controller.clear();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game Screen')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.games, size: 70, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                'Guess the Number!',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your guess',
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: checkGuess,
                child: const Text('Check Guess'),
              ),
              Text('Attempts: $attempts'),
              ElevatedButton(
                onPressed: restartGame,
                child: const Text('Restart Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
