import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../data/repositories/companion_repository_impl.dart';
import '../data/repositories/habit_repository_impl.dart';
import '../domain/repositories/companion_repository.dart';
import '../domain/repositories/habit_repository.dart';
import '../domain/usecases/complete_habit.dart';
import '../domain/usecases/create_habit.dart';
import '../domain/usecases/gain_xp_for_habit.dart';
import '../domain/usecases/get_today_habits.dart';

/// Root providers for dependency injection.
final isarProvider = Provider<Isar>(
  (ref) => throw UnimplementedError('Isar instance not initialized'),
);

final habitRepositoryProvider = Provider<HabitRepository>(
  (ref) => HabitRepositoryImpl(ref.read(isarProvider)),
);

final companionRepositoryProvider = Provider<CompanionRepository>(
  (ref) => CompanionRepositoryImpl(ref.read(isarProvider)),
);

final gainXpForHabitProvider = Provider<GainXpForHabit>(
  (ref) => const GainXpForHabit(),
);

final createHabitProvider = Provider<CreateHabit>(
  (ref) => CreateHabit(ref.read(habitRepositoryProvider)),
);

final getTodayHabitsProvider = Provider<GetTodayHabits>(
  (ref) => GetTodayHabits(ref.read(habitRepositoryProvider)),
);

final completeHabitProvider = Provider<CompleteHabit>(
  (ref) => CompleteHabit(
    repository: ref.read(habitRepositoryProvider),
    gainXpForHabit: ref.read(gainXpForHabitProvider),
  ),
);
