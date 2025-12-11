import 'package:isar/isar.dart';

import '../../domain/entities/companion.dart';
import '../../domain/repositories/companion_repository.dart';
import '../mappers/habit_mapper.dart';
import '../models/isar_companion.dart';

class CompanionRepositoryImpl implements CompanionRepository {
  final Isar isar;

  const CompanionRepositoryImpl(this.isar);

  @override
  Future<Companion> getCompanion() async {
    final existing = await isar.isarCompanions.where().findFirst();
    if (existing != null) {
      return toCompanion(existing);
    }

    // Provide a friendly default for a first-time user.
    const fallback = Companion(
      id: 'default-companion',
      name: 'Nova',
      avatarKey: 'sprout',
    );
    await saveCompanion(fallback);
    return fallback;
  }

  @override
  Future<void> saveCompanion(Companion companion) async {
    final model = toIsarCompanion(companion);
    await isar.writeTxn(() => isar.isarCompanions.put(model));
  }
}
