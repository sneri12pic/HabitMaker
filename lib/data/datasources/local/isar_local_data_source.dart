import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/isar_companion.dart';
import '../../models/isar_habit.dart';
import '../../models/isar_habit_log.dart';

class IsarLocalDataSource {
  static Future<Isar> open() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open([
      IsarHabitSchema,
      IsarHabitLogSchema,
      IsarCompanionSchema,
    ], directory: dir.path, name: 'habit_maker');
  }
}
