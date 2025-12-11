import 'package:isar/isar.dart';

import '../../domain/entities/habit.dart';
import '../../domain/entities/habit_log.dart';
import '../../domain/repositories/habit_repository.dart';
import '../mappers/habit_mapper.dart';
import '../models/isar_habit.dart';
import '../models/isar_habit_log.dart';

class HabitRepositoryImpl implements HabitRepository {
  final Isar isar;

  const HabitRepositoryImpl(this.isar);

  @override
  Future<void> createHabit(Habit habit) async {
    final model = toIsarHabit(habit);
    await isar.writeTxn(() => isar.isarHabits.put(model));
  }

  @override
  Future<List<Habit>> getHabitsForDate(DateTime date) async {
    final models = await isar.isarHabits.where().findAll();
    return models.map(toHabit).toList();
  }

  @override
  Future<Habit?> getHabitById(String id) async {
    final model =
        await isar.isarHabits.filter().externalIdEqualTo(id).findFirst();
    return model != null ? toHabit(model) : null;
  }

  @override
  Future<void> saveHabit(Habit habit) async {
    final model = toIsarHabit(habit);
    await isar.writeTxn(() => isar.isarHabits.put(model));
  }

  @override
  Future<void> logCompletion(String habitId, DateTime date) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final existing = await isar.isarHabitLogs
        .filter()
        .habitExternalIdEqualTo(habitId)
        .dateEqualTo(normalizedDate)
        .findFirst();

    if (existing != null) {
      return;
    }

    final log = IsarHabitLog()
      ..habitExternalId = habitId
      ..date = normalizedDate
      ..completed = true;

    await isar.writeTxn(() => isar.isarHabitLogs.put(log));
  }

  @override
  Future<List<HabitLog>> getLogs(String habitId, {int days = 30}) async {
    final startDate = DateTime.now().subtract(Duration(days: days));
    final models = await isar.isarHabitLogs
        .filter()
        .habitExternalIdEqualTo(habitId)
        .dateGreaterThan(startDate)
        .findAll();
    return models.map(toHabitLog).toList();
  }
}
