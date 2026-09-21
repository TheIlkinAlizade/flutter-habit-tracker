import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'daos/tracker_dao.dart';
import 'daos/entry_dao.dart';

part 'database.g.dart';

class Trackers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  IntColumn get color => integer()();
  TextColumn get icon => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get archivedAt => integer().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  TextColumn get scheduleType =>
      text().withDefault(const Constant('daily'))();
  TextColumn get scheduleConfig => text().nullable()();
}

class TrackerEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get trackerId =>
      integer().references(Trackers, #id, onDelete: KeyAction.cascade)();
  TextColumn get date => text()();
  BoolColumn get completed => boolean().withDefault(const Constant(true))();

  @override
  List<Set<Column>> get uniqueKeys => [
        {trackerId, date},
      ];
}

@DriftDatabase(
  tables: [Trackers, TrackerEntries],
  daos: [TrackerDao, EntryDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'habit_tracker.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}