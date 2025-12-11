import 'package:flutter/material.dart';

class HabitDetailScreen extends StatelessWidget {
  const HabitDetailScreen({super.key, required this.habitId});

  static const routeName = 'habitDetail';

  final String habitId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Habit details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Habit ID: $habitId'),
            const SizedBox(height: 12),
            const Text(
              'Streaks and history go here. Hook this up to HabitRepository.getLogs().',
            ),
          ],
        ),
      ),
    );
  }
}
