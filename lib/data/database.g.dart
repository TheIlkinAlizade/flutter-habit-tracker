// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TrackersTable extends Trackers with TableInfo<$TrackersTable, Tracker> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<int> archivedAt = GeneratedColumn<int>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _scheduleTypeMeta = const VerificationMeta(
    'scheduleType',
  );
  @override
  late final GeneratedColumn<String> scheduleType = GeneratedColumn<String>(
    'schedule_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('daily'),
  );
  static const VerificationMeta _scheduleConfigMeta = const VerificationMeta(
    'scheduleConfig',
  );
  @override
  late final GeneratedColumn<String> scheduleConfig = GeneratedColumn<String>(
    'schedule_config',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    color,
    icon,
    createdAt,
    archivedAt,
    sortOrder,
    scheduleType,
    scheduleConfig,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trackers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tracker> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('schedule_type')) {
      context.handle(
        _scheduleTypeMeta,
        scheduleType.isAcceptableOrUnknown(
          data['schedule_type']!,
          _scheduleTypeMeta,
        ),
      );
    }
    if (data.containsKey('schedule_config')) {
      context.handle(
        _scheduleConfigMeta,
        scheduleConfig.isAcceptableOrUnknown(
          data['schedule_config']!,
          _scheduleConfigMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tracker map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tracker(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}archived_at'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      scheduleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}schedule_type'],
      )!,
      scheduleConfig: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}schedule_config'],
      ),
    );
  }

  @override
  $TrackersTable createAlias(String alias) {
    return $TrackersTable(attachedDatabase, alias);
  }
}

class Tracker extends DataClass implements Insertable<Tracker> {
  final int id;
  final String name;
  final int color;
  final String? icon;
  final int createdAt;
  final int? archivedAt;
  final int sortOrder;
  final String scheduleType;
  final String? scheduleConfig;
  const Tracker({
    required this.id,
    required this.name,
    required this.color,
    this.icon,
    required this.createdAt,
    this.archivedAt,
    required this.sortOrder,
    required this.scheduleType,
    this.scheduleConfig,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['color'] = Variable<int>(color);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<int>(archivedAt);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['schedule_type'] = Variable<String>(scheduleType);
    if (!nullToAbsent || scheduleConfig != null) {
      map['schedule_config'] = Variable<String>(scheduleConfig);
    }
    return map;
  }

  TrackersCompanion toCompanion(bool nullToAbsent) {
    return TrackersCompanion(
      id: Value(id),
      name: Value(name),
      color: Value(color),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      createdAt: Value(createdAt),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      sortOrder: Value(sortOrder),
      scheduleType: Value(scheduleType),
      scheduleConfig: scheduleConfig == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduleConfig),
    );
  }

  factory Tracker.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tracker(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<int>(json['color']),
      icon: serializer.fromJson<String?>(json['icon']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      archivedAt: serializer.fromJson<int?>(json['archivedAt']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      scheduleType: serializer.fromJson<String>(json['scheduleType']),
      scheduleConfig: serializer.fromJson<String?>(json['scheduleConfig']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<int>(color),
      'icon': serializer.toJson<String?>(icon),
      'createdAt': serializer.toJson<int>(createdAt),
      'archivedAt': serializer.toJson<int?>(archivedAt),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'scheduleType': serializer.toJson<String>(scheduleType),
      'scheduleConfig': serializer.toJson<String?>(scheduleConfig),
    };
  }

  Tracker copyWith({
    int? id,
    String? name,
    int? color,
    Value<String?> icon = const Value.absent(),
    int? createdAt,
    Value<int?> archivedAt = const Value.absent(),
    int? sortOrder,
    String? scheduleType,
    Value<String?> scheduleConfig = const Value.absent(),
  }) => Tracker(
    id: id ?? this.id,
    name: name ?? this.name,
    color: color ?? this.color,
    icon: icon.present ? icon.value : this.icon,
    createdAt: createdAt ?? this.createdAt,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    sortOrder: sortOrder ?? this.sortOrder,
    scheduleType: scheduleType ?? this.scheduleType,
    scheduleConfig: scheduleConfig.present
        ? scheduleConfig.value
        : this.scheduleConfig,
  );
  Tracker copyWithCompanion(TrackersCompanion data) {
    return Tracker(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      icon: data.icon.present ? data.icon.value : this.icon,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      scheduleType: data.scheduleType.present
          ? data.scheduleType.value
          : this.scheduleType,
      scheduleConfig: data.scheduleConfig.present
          ? data.scheduleConfig.value
          : this.scheduleConfig,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tracker(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('createdAt: $createdAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('scheduleType: $scheduleType, ')
          ..write('scheduleConfig: $scheduleConfig')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    color,
    icon,
    createdAt,
    archivedAt,
    sortOrder,
    scheduleType,
    scheduleConfig,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tracker &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color &&
          other.icon == this.icon &&
          other.createdAt == this.createdAt &&
          other.archivedAt == this.archivedAt &&
          other.sortOrder == this.sortOrder &&
          other.scheduleType == this.scheduleType &&
          other.scheduleConfig == this.scheduleConfig);
}

class TrackersCompanion extends UpdateCompanion<Tracker> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> color;
  final Value<String?> icon;
  final Value<int> createdAt;
  final Value<int?> archivedAt;
  final Value<int> sortOrder;
  final Value<String> scheduleType;
  final Value<String?> scheduleConfig;
  const TrackersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.scheduleType = const Value.absent(),
    this.scheduleConfig = const Value.absent(),
  });
  TrackersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int color,
    this.icon = const Value.absent(),
    required int createdAt,
    this.archivedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.scheduleType = const Value.absent(),
    this.scheduleConfig = const Value.absent(),
  }) : name = Value(name),
       color = Value(color),
       createdAt = Value(createdAt);
  static Insertable<Tracker> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? color,
    Expression<String>? icon,
    Expression<int>? createdAt,
    Expression<int>? archivedAt,
    Expression<int>? sortOrder,
    Expression<String>? scheduleType,
    Expression<String>? scheduleConfig,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (icon != null) 'icon': icon,
      if (createdAt != null) 'created_at': createdAt,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (scheduleType != null) 'schedule_type': scheduleType,
      if (scheduleConfig != null) 'schedule_config': scheduleConfig,
    });
  }

  TrackersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? color,
    Value<String?>? icon,
    Value<int>? createdAt,
    Value<int?>? archivedAt,
    Value<int>? sortOrder,
    Value<String>? scheduleType,
    Value<String?>? scheduleConfig,
  }) {
    return TrackersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
      archivedAt: archivedAt ?? this.archivedAt,
      sortOrder: sortOrder ?? this.sortOrder,
      scheduleType: scheduleType ?? this.scheduleType,
      scheduleConfig: scheduleConfig ?? this.scheduleConfig,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<int>(archivedAt.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (scheduleType.present) {
      map['schedule_type'] = Variable<String>(scheduleType.value);
    }
    if (scheduleConfig.present) {
      map['schedule_config'] = Variable<String>(scheduleConfig.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('createdAt: $createdAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('scheduleType: $scheduleType, ')
          ..write('scheduleConfig: $scheduleConfig')
          ..write(')'))
        .toString();
  }
}

class $TrackerEntriesTable extends TrackerEntries
    with TableInfo<$TrackerEntriesTable, TrackerEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackerEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _trackerIdMeta = const VerificationMeta(
    'trackerId',
  );
  @override
  late final GeneratedColumn<int> trackerId = GeneratedColumn<int>(
    'tracker_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trackers (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, trackerId, date, completed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tracker_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrackerEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tracker_id')) {
      context.handle(
        _trackerIdMeta,
        trackerId.isAcceptableOrUnknown(data['tracker_id']!, _trackerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_trackerIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {trackerId, date},
  ];
  @override
  TrackerEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackerEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      trackerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tracker_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
    );
  }

  @override
  $TrackerEntriesTable createAlias(String alias) {
    return $TrackerEntriesTable(attachedDatabase, alias);
  }
}

class TrackerEntry extends DataClass implements Insertable<TrackerEntry> {
  final int id;
  final int trackerId;
  final String date;
  final bool completed;
  const TrackerEntry({
    required this.id,
    required this.trackerId,
    required this.date,
    required this.completed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tracker_id'] = Variable<int>(trackerId);
    map['date'] = Variable<String>(date);
    map['completed'] = Variable<bool>(completed);
    return map;
  }

  TrackerEntriesCompanion toCompanion(bool nullToAbsent) {
    return TrackerEntriesCompanion(
      id: Value(id),
      trackerId: Value(trackerId),
      date: Value(date),
      completed: Value(completed),
    );
  }

  factory TrackerEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackerEntry(
      id: serializer.fromJson<int>(json['id']),
      trackerId: serializer.fromJson<int>(json['trackerId']),
      date: serializer.fromJson<String>(json['date']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'trackerId': serializer.toJson<int>(trackerId),
      'date': serializer.toJson<String>(date),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  TrackerEntry copyWith({
    int? id,
    int? trackerId,
    String? date,
    bool? completed,
  }) => TrackerEntry(
    id: id ?? this.id,
    trackerId: trackerId ?? this.trackerId,
    date: date ?? this.date,
    completed: completed ?? this.completed,
  );
  TrackerEntry copyWithCompanion(TrackerEntriesCompanion data) {
    return TrackerEntry(
      id: data.id.present ? data.id.value : this.id,
      trackerId: data.trackerId.present ? data.trackerId.value : this.trackerId,
      date: data.date.present ? data.date.value : this.date,
      completed: data.completed.present ? data.completed.value : this.completed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackerEntry(')
          ..write('id: $id, ')
          ..write('trackerId: $trackerId, ')
          ..write('date: $date, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, trackerId, date, completed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackerEntry &&
          other.id == this.id &&
          other.trackerId == this.trackerId &&
          other.date == this.date &&
          other.completed == this.completed);
}

class TrackerEntriesCompanion extends UpdateCompanion<TrackerEntry> {
  final Value<int> id;
  final Value<int> trackerId;
  final Value<String> date;
  final Value<bool> completed;
  const TrackerEntriesCompanion({
    this.id = const Value.absent(),
    this.trackerId = const Value.absent(),
    this.date = const Value.absent(),
    this.completed = const Value.absent(),
  });
  TrackerEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int trackerId,
    required String date,
    this.completed = const Value.absent(),
  }) : trackerId = Value(trackerId),
       date = Value(date);
  static Insertable<TrackerEntry> custom({
    Expression<int>? id,
    Expression<int>? trackerId,
    Expression<String>? date,
    Expression<bool>? completed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trackerId != null) 'tracker_id': trackerId,
      if (date != null) 'date': date,
      if (completed != null) 'completed': completed,
    });
  }

  TrackerEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? trackerId,
    Value<String>? date,
    Value<bool>? completed,
  }) {
    return TrackerEntriesCompanion(
      id: id ?? this.id,
      trackerId: trackerId ?? this.trackerId,
      date: date ?? this.date,
      completed: completed ?? this.completed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (trackerId.present) {
      map['tracker_id'] = Variable<int>(trackerId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackerEntriesCompanion(')
          ..write('id: $id, ')
          ..write('trackerId: $trackerId, ')
          ..write('date: $date, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TrackersTable trackers = $TrackersTable(this);
  late final $TrackerEntriesTable trackerEntries = $TrackerEntriesTable(this);
  late final TrackerDao trackerDao = TrackerDao(this as AppDatabase);
  late final EntryDao entryDao = EntryDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    trackers,
    trackerEntries,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'trackers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tracker_entries', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$TrackersTableCreateCompanionBuilder =
    TrackersCompanion Function({
      Value<int> id,
      required String name,
      required int color,
      Value<String?> icon,
      required int createdAt,
      Value<int?> archivedAt,
      Value<int> sortOrder,
      Value<String> scheduleType,
      Value<String?> scheduleConfig,
    });
typedef $$TrackersTableUpdateCompanionBuilder =
    TrackersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> color,
      Value<String?> icon,
      Value<int> createdAt,
      Value<int?> archivedAt,
      Value<int> sortOrder,
      Value<String> scheduleType,
      Value<String?> scheduleConfig,
    });

final class $$TrackersTableReferences
    extends BaseReferences<_$AppDatabase, $TrackersTable, Tracker> {
  $$TrackersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TrackerEntriesTable, List<TrackerEntry>>
  _trackerEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.trackerEntries,
    aliasName: 'trackers__id__tracker_entries__tracker_id',
  );

  $$TrackerEntriesTableProcessedTableManager get trackerEntriesRefs {
    final manager = $$TrackerEntriesTableTableManager(
      $_db,
      $_db.trackerEntries,
    ).filter((f) => f.trackerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_trackerEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TrackersTableFilterComposer
    extends Composer<_$AppDatabase, $TrackersTable> {
  $$TrackersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheduleConfig => $composableBuilder(
    column: $table.scheduleConfig,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> trackerEntriesRefs(
    Expression<bool> Function($$TrackerEntriesTableFilterComposer f) f,
  ) {
    final $$TrackerEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trackerEntries,
      getReferencedColumn: (t) => t.trackerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackerEntriesTableFilterComposer(
            $db: $db,
            $table: $db.trackerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TrackersTableOrderingComposer
    extends Composer<_$AppDatabase, $TrackersTable> {
  $$TrackersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduleConfig => $composableBuilder(
    column: $table.scheduleConfig,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TrackersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrackersTable> {
  $$TrackersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scheduleConfig => $composableBuilder(
    column: $table.scheduleConfig,
    builder: (column) => column,
  );

  Expression<T> trackerEntriesRefs<T extends Object>(
    Expression<T> Function($$TrackerEntriesTableAnnotationComposer a) f,
  ) {
    final $$TrackerEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trackerEntries,
      getReferencedColumn: (t) => t.trackerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackerEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.trackerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TrackersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrackersTable,
          Tracker,
          $$TrackersTableFilterComposer,
          $$TrackersTableOrderingComposer,
          $$TrackersTableAnnotationComposer,
          $$TrackersTableCreateCompanionBuilder,
          $$TrackersTableUpdateCompanionBuilder,
          (Tracker, $$TrackersTableReferences),
          Tracker,
          PrefetchHooks Function({bool trackerEntriesRefs})
        > {
  $$TrackersTableTableManager(_$AppDatabase db, $TrackersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrackersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrackersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrackersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int?> archivedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> scheduleType = const Value.absent(),
                Value<String?> scheduleConfig = const Value.absent(),
              }) => TrackersCompanion(
                id: id,
                name: name,
                color: color,
                icon: icon,
                createdAt: createdAt,
                archivedAt: archivedAt,
                sortOrder: sortOrder,
                scheduleType: scheduleType,
                scheduleConfig: scheduleConfig,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int color,
                Value<String?> icon = const Value.absent(),
                required int createdAt,
                Value<int?> archivedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> scheduleType = const Value.absent(),
                Value<String?> scheduleConfig = const Value.absent(),
              }) => TrackersCompanion.insert(
                id: id,
                name: name,
                color: color,
                icon: icon,
                createdAt: createdAt,
                archivedAt: archivedAt,
                sortOrder: sortOrder,
                scheduleType: scheduleType,
                scheduleConfig: scheduleConfig,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TrackersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({trackerEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (trackerEntriesRefs) db.trackerEntries,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (trackerEntriesRefs)
                    await $_getPrefetchedData<
                      Tracker,
                      $TrackersTable,
                      TrackerEntry
                    >(
                      currentTable: table,
                      referencedTable: $$TrackersTableReferences
                          ._trackerEntriesRefsTable(db),
                      managerFromTypedResult: (p0) => $$TrackersTableReferences(
                        db,
                        table,
                        p0,
                      ).trackerEntriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.trackerId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TrackersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrackersTable,
      Tracker,
      $$TrackersTableFilterComposer,
      $$TrackersTableOrderingComposer,
      $$TrackersTableAnnotationComposer,
      $$TrackersTableCreateCompanionBuilder,
      $$TrackersTableUpdateCompanionBuilder,
      (Tracker, $$TrackersTableReferences),
      Tracker,
      PrefetchHooks Function({bool trackerEntriesRefs})
    >;
typedef $$TrackerEntriesTableCreateCompanionBuilder =
    TrackerEntriesCompanion Function({
      Value<int> id,
      required int trackerId,
      required String date,
      Value<bool> completed,
    });
typedef $$TrackerEntriesTableUpdateCompanionBuilder =
    TrackerEntriesCompanion Function({
      Value<int> id,
      Value<int> trackerId,
      Value<String> date,
      Value<bool> completed,
    });

final class $$TrackerEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $TrackerEntriesTable, TrackerEntry> {
  $$TrackerEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TrackersTable _trackerIdTable(_$AppDatabase db) =>
      db.trackers.createAlias('tracker_entries__tracker_id__trackers__id');

  $$TrackersTableProcessedTableManager get trackerId {
    final $_column = $_itemColumn<int>('tracker_id')!;

    final manager = $$TrackersTableTableManager(
      $_db,
      $_db.trackers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trackerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TrackerEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $TrackerEntriesTable> {
  $$TrackerEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  $$TrackersTableFilterComposer get trackerId {
    final $$TrackersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackerId,
      referencedTable: $db.trackers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackersTableFilterComposer(
            $db: $db,
            $table: $db.trackers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackerEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $TrackerEntriesTable> {
  $$TrackerEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  $$TrackersTableOrderingComposer get trackerId {
    final $$TrackersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackerId,
      referencedTable: $db.trackers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackersTableOrderingComposer(
            $db: $db,
            $table: $db.trackers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackerEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrackerEntriesTable> {
  $$TrackerEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  $$TrackersTableAnnotationComposer get trackerId {
    final $$TrackersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackerId,
      referencedTable: $db.trackers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackersTableAnnotationComposer(
            $db: $db,
            $table: $db.trackers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackerEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrackerEntriesTable,
          TrackerEntry,
          $$TrackerEntriesTableFilterComposer,
          $$TrackerEntriesTableOrderingComposer,
          $$TrackerEntriesTableAnnotationComposer,
          $$TrackerEntriesTableCreateCompanionBuilder,
          $$TrackerEntriesTableUpdateCompanionBuilder,
          (TrackerEntry, $$TrackerEntriesTableReferences),
          TrackerEntry,
          PrefetchHooks Function({bool trackerId})
        > {
  $$TrackerEntriesTableTableManager(
    _$AppDatabase db,
    $TrackerEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrackerEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrackerEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrackerEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> trackerId = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<bool> completed = const Value.absent(),
              }) => TrackerEntriesCompanion(
                id: id,
                trackerId: trackerId,
                date: date,
                completed: completed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int trackerId,
                required String date,
                Value<bool> completed = const Value.absent(),
              }) => TrackerEntriesCompanion.insert(
                id: id,
                trackerId: trackerId,
                date: date,
                completed: completed,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TrackerEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({trackerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (trackerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.trackerId,
                                referencedTable: $$TrackerEntriesTableReferences
                                    ._trackerIdTable(db),
                                referencedColumn:
                                    $$TrackerEntriesTableReferences
                                        ._trackerIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TrackerEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrackerEntriesTable,
      TrackerEntry,
      $$TrackerEntriesTableFilterComposer,
      $$TrackerEntriesTableOrderingComposer,
      $$TrackerEntriesTableAnnotationComposer,
      $$TrackerEntriesTableCreateCompanionBuilder,
      $$TrackerEntriesTableUpdateCompanionBuilder,
      (TrackerEntry, $$TrackerEntriesTableReferences),
      TrackerEntry,
      PrefetchHooks Function({bool trackerId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TrackersTableTableManager get trackers =>
      $$TrackersTableTableManager(_db, _db.trackers);
  $$TrackerEntriesTableTableManager get trackerEntries =>
      $$TrackerEntriesTableTableManager(_db, _db.trackerEntries);
}
