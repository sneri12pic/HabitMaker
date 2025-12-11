import 'package:isar/isar.dart';

import '../../domain/entities/habit_frequency.dart';

part 'isar_habit.g.dart';

enum HabitFrequencyDto {
  daily,
  weekly,
}

HabitFrequencyDto mapToDto(HabitFrequency frequency) {
  switch (frequency) {
    case HabitFrequency.daily:
      return HabitFrequencyDto.daily;
    case HabitFrequency.weekly:
      return HabitFrequencyDto.weekly;
  }
}

HabitFrequency mapToEntity(HabitFrequencyDto frequency) {
  switch (frequency) {
    case HabitFrequencyDto.daily:
      return HabitFrequency.daily;
    case HabitFrequencyDto.weekly:
      return HabitFrequency.weekly;
  }
}

@Collection()
class IsarHabit {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  late String externalId;
  late String name;
  late String emoji;
  @Enumerated(EnumType.name)
  late HabitFrequencyDto frequency;
  int timesPerPeriod = 1;
  int baseXp = 10;
  int level = 1;
  int currentXp = 0;
}
