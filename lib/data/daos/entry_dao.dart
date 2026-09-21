import 'package:drift/drift.dart';
import '../database.dart';

part 'entry_dao.g.dart';

@DriftAccessor(tables: [TrackerEntries])
class EntryDao extends DatabaseAccessor<AppDatabase> with _$EntryDaoMixin {
  EntryDao(super.db);

  Stream<List<TrackerEntry>> watchEntriesForTracker(int trackerId) {
    return (select(trackerEntries)
          ..where((e) => e.trackerId.equals(trackerId))
          ..orderBy([(e) => OrderingTerm.asc(e.date)]))
        .watch();
  }

  Future<void> markDone(int trackerId, String date) {
    return into(trackerEntries).insertOnConflictUpdate(
      TrackerEntriesCompanion.insert(
        trackerId: trackerId,
        date: date,
        completed: const Value(true),
      ),
    );
  }

  Future<void> markNotDone(int trackerId, String date) {
    return (delete(trackerEntries)
          ..where((e) => e.trackerId.equals(trackerId) & e.date.equals(date)))
        .go();
  }

  Future<void> toggleDay(int trackerId, String date, bool currentlyDone) {
    return currentlyDone ? markNotDone(trackerId, date) : markDone(trackerId, date);
  }
}