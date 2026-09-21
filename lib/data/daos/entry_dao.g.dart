// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_dao.dart';

// ignore_for_file: type=lint
mixin _$EntryDaoMixin on DatabaseAccessor<AppDatabase> {
  $TrackersTable get trackers => attachedDatabase.trackers;
  $TrackerEntriesTable get trackerEntries => attachedDatabase.trackerEntries;
  EntryDaoManager get managers => EntryDaoManager(this);
}

class EntryDaoManager {
  final _$EntryDaoMixin _db;
  EntryDaoManager(this._db);
  $$TrackersTableTableManager get trackers =>
      $$TrackersTableTableManager(_db.attachedDatabase, _db.trackers);
  $$TrackerEntriesTableTableManager get trackerEntries =>
      $$TrackerEntriesTableTableManager(
        _db.attachedDatabase,
        _db.trackerEntries,
      );
}
