class HabitLog {
  final String habitId;
  final DateTime date;
  final bool completed;

  const HabitLog({
    required this.habitId,
    required this.date,
    this.completed = true,
  });

  /// Normalizes the date to YYYY-MM-DD for streak calculations.
  DateTime get dayOnly => DateTime(date.year, date.month, date.day);
}
