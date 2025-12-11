import '../entities/habit.dart';
import '../repositories/habit_repository.dart';
import 'gain_xp_for_habit.dart';

class CompleteHabit {
  final HabitRepository repository;
  final GainXpForHabit gainXpForHabit;

  const CompleteHabit({
    required this.repository,
    required this.gainXpForHabit,
  });

  Future<Habit> call(String habitId, DateTime date) async {
    final habit = await repository.getHabitById(habitId);
    if (habit == null) {
      throw StateError('Habit not found: $habitId');
    }

    final updated = gainXpForHabit(habit, habit.baseXp);
    await repository.saveHabit(updated);
    await repository.logCompletion(habitId, date);
    return updated;
  }
}
