import 'package:isar/isar.dart';

part 'isar_companion.g.dart';

@Collection()
class IsarCompanion {
  Id id = Isar.autoIncrement;
  late String externalId;
  late String name;
  late String avatarKey;
}
