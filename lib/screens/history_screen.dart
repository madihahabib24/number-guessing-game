import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final DatabaseHelper db = DatabaseHelper();

  late Future<List<Map<String, dynamic>>> history;

  @override
  void initState() {
    super.initState();
    history = db.getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game History')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: history,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading history'));
          }

          final records = snapshot.data ?? [];

          if (records.isEmpty) {
            return const Center(child: Text('No history found'));
          }

          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final item = records[index];

              return ListTile(
                leading: const Icon(Icons.history),
                title: Text('Guess: ${item['guess']}'),
                subtitle: Text('Result: ${item['result']}'),
              );
            },
          );
        },
      ),
    );
  }
}
