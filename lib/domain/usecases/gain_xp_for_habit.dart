import '../entities/habit.dart';

/// Pure XP/level math so it stays easy to test without Flutter bindings.
class GainXpForHabit {
  const GainXpForHabit();

  Habit call(Habit habit, int gainedXp) {
    var xpPool = habit.currentXp + gainedXp;
    var level = habit.level;

    // Apply XP and allow multiple level-ups in one go.
    while (xpPool >= xpForLevel(level)) {
      xpPool -= xpForLevel(level);
      level++;
    }

    return habit.copyWith(level: level, currentXp: xpPool);
  }

  /// Simple, tweakable XP curve: +25 XP required per level after the first.
  static int xpForLevel(int level) {
    return 50 + (level - 1) * 25;
  }
}
