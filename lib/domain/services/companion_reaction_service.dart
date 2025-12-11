import '../entities/companion.dart';

enum CompanionEventType { habitLeveledUp, streakMilestone, streakBroken }

class CompanionEvent {
  final CompanionEventType type;
  final int? value;

  const CompanionEvent({
    required this.type,
    this.value,
  });
}

/// Simple, local-only service that can later be expanded with more variety.
class CompanionReactionService {
  String reactionForEvent(Companion companion, CompanionEvent event) {
    switch (event.type) {
      case CompanionEventType.habitLeveledUp:
        return '${companion.name}: We just leveled up this habit! 🔥';
      case CompanionEventType.streakBroken:
        return '${companion.name}: Let us start a new streak today.';
      case CompanionEventType.streakMilestone:
        final days = event.value ?? 0;
        return '${companion.name}: $days-day streak! Keep the momentum!';
    }
  }
}
