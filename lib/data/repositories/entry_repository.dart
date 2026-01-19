import 'package:isar/isar.dart';
import '../models/day_entry.dart';
import '../../services/isar_service.dart';

class EntryRepository {
  final Isar _isar = IsarService.isar;

  // Tüm kayıtları getir
  Future<List<DayEntry>> getAllEntries() async {
    return await _isar.dayEntrys.where().sortByDateDesc().findAll();
  }

  // Belirli bir tarihe göre kayıt getir
  Future<DayEntry?> getEntryByDate(DateTime date) async {
    final dateOnly = DateTime(date.year, date.month, date.day);
    return await _isar.dayEntrys.filter().dateOnlyEqualTo(dateOnly).findFirst();
  }

  // Kayıt ekle/güncelle
  Future<void> saveEntry(String content, DateTime date) async {
    final entry = DayEntry()
      ..date = date
      ..content = content;

    await _isar.writeTxn(() async {
      await _isar.dayEntrys.put(entry);
    });
  }

  // Kayıt sil
  Future<void> deleteEntry(int id) async {
    await _isar.writeTxn(() async {
      await _isar.dayEntrys.delete(id);
    });
  }

  // Son 30 günün kayıtlarını getir
  Future<List<DayEntry>> getLast30Days() async {
    final thirtyDaysAgo = DateTime.now().subtract(Duration(days: 30));
    return await _isar.dayEntrys
        .filter()
        .dateGreaterThan(thirtyDaysAgo)
        .sortByDateDesc()
        .findAll();
  }
}
