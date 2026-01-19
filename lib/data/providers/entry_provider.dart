import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneday_oneline/data/models/day_entry.dart';
import 'package:oneday_oneline/data/repositories/entry_repository.dart';

// Repository provider
final entryRepositoryProvider = Provider((ref) => EntryRepository());

// Bugünün kaydı provider
final todayEntryProvider = FutureProvider<DayEntry?>((ref) async {
  final repository = ref.watch(entryRepositoryProvider);
  return await repository.getEntryByDate(DateTime.now());
});

// Son 30 gün provider
final recentEntriesProvider = FutureProvider<List<DayEntry>>((ref) async {
  final repository = ref.watch(entryRepositoryProvider);
  return await repository.getLast30Days();
});

// Kayıt kontrolcüsü
final entryControllerProvider =
    StateNotifierProvider<EntryController, AsyncValue<void>>((ref) {
      return EntryController(ref.watch(entryRepositoryProvider));
    });

class EntryController extends StateNotifier<AsyncValue<void>> {
  final EntryRepository _repository;

  EntryController(this._repository) : super(const AsyncValue.data(null));

  Future<void> saveEntry(String content, DateTime date) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.saveEntry(content, date);
    });
  }

  Future<void> deleteEntry(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.deleteEntry(id);
    });
  }
}
