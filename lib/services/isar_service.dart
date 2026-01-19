import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../data/models/day_entry.dart';

class IsarService {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([DayEntrySchema], directory: dir.path);
  }
}
