import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/create_habit/create_habit_screen.dart';
import '../../presentation/screens/habit_detail/habit_detail_screen.dart';
import '../../presentation/screens/today/today_screen.dart';

/// Centralized router to keep navigation declarative and testable.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: TodayScreen.routeName,
        builder: (context, state) => const TodayScreen(),
        routes: [
          GoRoute(
            path: 'create',
            name: CreateHabitScreen.routeName,
            builder: (context, state) => const CreateHabitScreen(),
          ),
          GoRoute(
            path: 'habit/:id',
            name: HabitDetailScreen.routeName,
            builder: (context, state) {
              final habitId = state.pathParameters['id']!;
              return HabitDetailScreen(habitId: habitId);
            },
          ),
        ],
      ),
    ],
  );
});
