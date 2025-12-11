import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/habit.dart';
import '../../domain/usecases/complete_habit.dart';
import '../../domain/usecases/get_today_habits.dart';

class TodayHabitsState {
  final bool isLoading;
  final List<Habit> habits;
  final String? error;

  const TodayHabitsState({
    this.isLoading = false,
    this.habits = const [],
    this.error,
  });

  TodayHabitsState copyWith({
    bool? isLoading,
    List<Habit>? habits,
    String? error,
  }) {
    return TodayHabitsState(
      isLoading: isLoading ?? this.isLoading,
      habits: habits ?? this.habits,
      error: error,
    );
  }
}

class TodayHabitsNotifier extends StateNotifier<TodayHabitsState> {
  TodayHabitsNotifier({
    required GetTodayHabits getTodayHabits,
    required CompleteHabit completeHabit,
  }) : _getTodayHabits = getTodayHabits,
       _completeHabit = completeHabit,
       super(const TodayHabitsState());

  final GetTodayHabits _getTodayHabits;
  final CompleteHabit _completeHabit;

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final habits = await _getTodayHabits(DateTime.now());
      state = state.copyWith(isLoading: false, habits: habits);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to load habits');
    }
  }

  Future<void> markDone(Habit habit) async {
    state = state.copyWith(isLoading: true);
    try {
      final updated = await _completeHabit(habit.id, DateTime.now());
      final updatedList = [
        for (final h in state.habits)
          if (h.id == updated.id) updated else h,
      ];
      state = state.copyWith(isLoading: false, habits: updatedList);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Could not complete habit',
      );
    }
  }
}
