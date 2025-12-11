import '../entities/companion.dart';

abstract class CompanionRepository {
  Future<Companion> getCompanion();

  Future<void> saveCompanion(Companion companion);
}
