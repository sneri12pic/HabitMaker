import 'habit_frequency.dart';

class Habit {
  final String id;
  final String name;
  final String emoji;
  final HabitFrequency frequency;
  final int timesPerPeriod;
  final int baseXp;
  final int level;
  final int currentXp;

  const Habit({
    required this.id,
    required this.name,
    required this.emoji,
    required this.frequency,
    this.timesPerPeriod = 1,
    this.baseXp = 10,
    this.level = 1,
    this.currentXp = 0,
  });

  Habit copyWith({
    String? id,
    String? name,
    String? emoji,
    HabitFrequency? frequency,
    int? timesPerPeriod,
    int? baseXp,
    int? level,
    int? currentXp,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      frequency: frequency ?? this.frequency,
      timesPerPeriod: timesPerPeriod ?? this.timesPerPeriod,
      baseXp: baseXp ?? this.baseXp,
      level: level ?? this.level,
      currentXp: currentXp ?? this.currentXp,
    );
  }

  @override
  String toString() {
    return 'Habit(id: $id, name: $name, level: $level, xp: $currentXp)';
  }
}
