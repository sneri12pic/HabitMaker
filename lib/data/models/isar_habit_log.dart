import 'package:isar/isar.dart';

part 'isar_habit_log.g.dart';

@Collection()
class IsarHabitLog {
  Id id = Isar.autoIncrement;
  late String habitExternalId;
  @Index()
  late DateTime date;
  bool completed = true;
}
