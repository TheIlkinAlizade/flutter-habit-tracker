import 'package:drift/drift.dart';
import '../database.dart';

part 'tracker_dao.g.dart';

@DriftAccessor(tables: [Trackers])
class TrackerDao extends DatabaseAccessor<AppDatabase> with _$TrackerDaoMixin {
  TrackerDao(super.db);

  Stream<List<Tracker>> watchActiveTrackers() {
    return (select(trackers)
          ..where((t) => t.archivedAt.isNull())
          ..orderBy([
            (t) => OrderingTerm.asc(t.sortOrder),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .watch();
  }

  Future<Tracker> createTracker({
    required String name,
    required int color,
    String? icon,
    String scheduleType = 'daily',
    String? scheduleConfig,
  }) async {
    final id = await into(trackers).insert(
      TrackersCompanion.insert(
        name: name,
        color: color,
        icon: Value(icon),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        scheduleType: Value(scheduleType),
        scheduleConfig: Value(scheduleConfig),
      ),
    );
    return (select(trackers)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> updateTracker(Tracker tracker) {
    return update(trackers).replace(tracker);
  }

  Future<void> archiveTracker(int id) {
    return (update(trackers)..where((t) => t.id.equals(id))).write(
      TrackersCompanion(archivedAt: Value(DateTime.now().millisecondsSinceEpoch)),
    );
  }

  Future<void> unarchiveTracker(int id) {
    return (update(trackers)..where((t) => t.id.equals(id))).write(
      const TrackersCompanion(archivedAt: Value(null)),
    );
  }

  Future<void> deleteTrackerPermanently(int id) {
    return (delete(trackers)..where((t) => t.id.equals(id))).go();
  }
}