import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/usecases/gain_xp_for_habit.dart';
import '../../providers.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  static const routeName = 'today';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(todayHabitsNotifierProvider);
    final notifier = ref.read(todayHabitsNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Maker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/create'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => notifier.load(),
        child: Builder(
          builder: (context) {
            if (state.isLoading && state.habits.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.habits.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 120),
                  Center(child: Text('No habits yet. Create your first one!')),
                ],
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.habits.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final habit = state.habits[index];
                final xpForNext = GainXpForHabit.xpForLevel(habit.level);
                final progress =
                    (habit.currentXp / xpForNext).clamp(0.0, 1.0).toDouble();

                return Card(
                  child: InkWell(
                    onTap: () => context.push('/habit/${habit.id}'),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(habit.emoji, style: const TextStyle(fontSize: 24)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      habit.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Text('Lv ${habit.level}'),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () => notifier.markDone(habit),
                                child: const Text('Done'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(value: progress),
                          const SizedBox(height: 4),
                          Text('${habit.currentXp} / $xpForNext XP'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
