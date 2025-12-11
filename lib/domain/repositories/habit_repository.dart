import '../entities/habit.dart';
import '../entities/habit_log.dart';

abstract class HabitRepository {
  Future<void> createHabit(Habit habit);

  Future<List<Habit>> getHabitsForDate(DateTime date);

  Future<Habit?> getHabitById(String id);

  Future<void> saveHabit(Habit habit);

  Future<void> logCompletion(String habitId, DateTime date);

  Future<List<HabitLog>> getLogs(String habitId, {int days});
}
