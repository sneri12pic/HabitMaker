import '../entities/habit.dart';
import '../repositories/habit_repository.dart';

class CreateHabit {
  final HabitRepository repository;

  const CreateHabit(this.repository);

  Future<void> call(Habit habit) {
    return repository.createHabit(habit);
  }
}
