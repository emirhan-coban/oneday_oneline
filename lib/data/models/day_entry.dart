import 'package:isar/isar.dart';

part 'day_entry.g.dart';

@collection
class DayEntry {
  Id id = Isar.autoIncrement;

  late DateTime date;
  late String content;

  @Index()
  DateTime get dateOnly => DateTime(date.year, date.month, date.day);
}
