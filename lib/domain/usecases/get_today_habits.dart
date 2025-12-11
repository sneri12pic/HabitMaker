import '../entities/habit.dart';
import '../repositories/habit_repository.dart';

class GetTodayHabits {
  final HabitRepository repository;

  const GetTodayHabits(this.repository);

  Future<List<Habit>> call(DateTime date) {
    return repository.getHabitsForDate(date);
  }
}
