import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';
import '../domain/usecases/complete_habit.dart';
import '../domain/usecases/get_today_habits.dart';
import 'notifiers/today_habits_notifier.dart';

final todayHabitsNotifierProvider =
    StateNotifierProvider.autoDispose<TodayHabitsNotifier, TodayHabitsState>(
  (ref) {
    final getTodayHabits = ref.read(getTodayHabitsProvider);
    final completeHabit = ref.read(completeHabitProvider);
    final notifier = TodayHabitsNotifier(
      getTodayHabits: getTodayHabits,
      completeHabit: completeHabit,
    );
    notifier.load();
    return notifier;
  },
);
