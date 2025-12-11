import '../../domain/entities/companion.dart';
import '../../domain/entities/habit.dart';
import '../../domain/entities/habit_log.dart';
import '../models/isar_companion.dart';
import '../models/isar_habit.dart';
import '../models/isar_habit_log.dart';

IsarHabit toIsarHabit(Habit habit) {
  final model = IsarHabit()
    ..externalId = habit.id
    ..name = habit.name
    ..emoji = habit.emoji
    ..frequency = mapToDto(habit.frequency)
    ..timesPerPeriod = habit.timesPerPeriod
    ..baseXp = habit.baseXp
    ..level = habit.level
    ..currentXp = habit.currentXp;
  return model;
}

Habit toHabit(IsarHabit model) {
  return Habit(
    id: model.externalId,
    name: model.name,
    emoji: model.emoji,
    frequency: mapToEntity(model.frequency),
    timesPerPeriod: model.timesPerPeriod,
    baseXp: model.baseXp,
    level: model.level,
    currentXp: model.currentXp,
  );
}

IsarHabitLog toIsarHabitLog(HabitLog log) {
  final model = IsarHabitLog()
    ..habitExternalId = log.habitId
    ..date = log.dayOnly
    ..completed = log.completed;
  return model;
}

HabitLog toHabitLog(IsarHabitLog model) {
  return HabitLog(
    habitId: model.habitExternalId,
    date: model.date,
    completed: model.completed,
  );
}

IsarCompanion toIsarCompanion(Companion companion) {
  final model = IsarCompanion()
    ..externalId = companion.id
    ..name = companion.name
    ..avatarKey = companion.avatarKey;
  return model;
}

Companion toCompanion(IsarCompanion model) {
  return Companion(
    id: model.externalId,
    name: model.name,
    avatarKey: model.avatarKey,
  );
}
