// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppDB.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Host extends DataClass implements Insertable<Host> {
  final int id;
  final String hostName;
  final String ip;
  final int version;
  final String readCommunityString;
  final String writeCommunityString;
  final String note;
  Host(
      {required this.id,
      required this.hostName,
      required this.ip,
      required this.version,
      required this.readCommunityString,
      required this.writeCommunityString,
      required this.note});
  factory Host.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Host(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      hostName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}host_name'])!,
      ip: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}ip'])!,
      version: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}version'])!,
      readCommunityString: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}read_community_string'])!,
      writeCommunityString: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}write_community_string'])!,
      note: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}note'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['host_name'] = Variable<String>(hostName);
    map['ip'] = Variable<String>(ip);
    map['version'] = Variable<int>(version);
    map['read_community_string'] = Variable<String>(readCommunityString);
    map['write_community_string'] = Variable<String>(writeCommunityString);
    map['note'] = Variable<String>(note);
    return map;
  }

  HostsCompanion toCompanion(bool nullToAbsent) {
    return HostsCompanion(
      id: Value(id),
      hostName: Value(hostName),
      ip: Value(ip),
      version: Value(version),
      readCommunityString: Value(readCommunityString),
      writeCommunityString: Value(writeCommunityString),
      note: Value(note),
    );
  }

  factory Host.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Host(
      id: serializer.fromJson<int>(json['id']),
      hostName: serializer.fromJson<String>(json['hostName']),
      ip: serializer.fromJson<String>(json['ip']),
      version: serializer.fromJson<int>(json['version']),
      readCommunityString:
          serializer.fromJson<String>(json['readCommunityString']),
      writeCommunityString:
          serializer.fromJson<String>(json['writeCommunityString']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'hostName': serializer.toJson<String>(hostName),
      'ip': serializer.toJson<String>(ip),
      'version': serializer.toJson<int>(version),
      'readCommunityString': serializer.toJson<String>(readCommunityString),
      'writeCommunityString': serializer.toJson<String>(writeCommunityString),
      'note': serializer.toJson<String>(note),
    };
  }

  Host copyWith(
          {int? id,
          String? hostName,
          String? ip,
          int? version,
          String? readCommunityString,
          String? writeCommunityString,
          String? note}) =>
      Host(
        id: id ?? this.id,
        hostName: hostName ?? this.hostName,
        ip: ip ?? this.ip,
        version: version ?? this.version,
        readCommunityString: readCommunityString ?? this.readCommunityString,
        writeCommunityString: writeCommunityString ?? this.writeCommunityString,
        note: note ?? this.note,
      );
  @override
  String toString() {
    return (StringBuffer('Host(')
          ..write('id: $id, ')
          ..write('hostName: $hostName, ')
          ..write('ip: $ip, ')
          ..write('version: $version, ')
          ..write('readCommunityString: $readCommunityString, ')
          ..write('writeCommunityString: $writeCommunityString, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, hostName, ip, version,
      readCommunityString, writeCommunityString, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Host &&
          other.id == this.id &&
          other.hostName == this.hostName &&
          other.ip == this.ip &&
          other.version == this.version &&
          other.readCommunityString == this.readCommunityString &&
          other.writeCommunityString == this.writeCommunityString &&
          other.note == this.note);
}

class HostsCompanion extends UpdateCompanion<Host> {
  final Value<int> id;
  final Value<String> hostName;
  final Value<String> ip;
  final Value<int> version;
  final Value<String> readCommunityString;
  final Value<String> writeCommunityString;
  final Value<String> note;
  const HostsCompanion({
    this.id = const Value.absent(),
    this.hostName = const Value.absent(),
    this.ip = const Value.absent(),
    this.version = const Value.absent(),
    this.readCommunityString = const Value.absent(),
    this.writeCommunityString = const Value.absent(),
    this.note = const Value.absent(),
  });
  HostsCompanion.insert({
    this.id = const Value.absent(),
    required String hostName,
    required String ip,
    this.version = const Value.absent(),
    this.readCommunityString = const Value.absent(),
    required String writeCommunityString,
    required String note,
  })  : hostName = Value(hostName),
        ip = Value(ip),
        writeCommunityString = Value(writeCommunityString),
        note = Value(note);
  static Insertable<Host> custom({
    Expression<int>? id,
    Expression<String>? hostName,
    Expression<String>? ip,
    Expression<int>? version,
    Expression<String>? readCommunityString,
    Expression<String>? writeCommunityString,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hostName != null) 'host_name': hostName,
      if (ip != null) 'ip': ip,
      if (version != null) 'version': version,
      if (readCommunityString != null)
        'read_community_string': readCommunityString,
      if (writeCommunityString != null)
        'write_community_string': writeCommunityString,
      if (note != null) 'note': note,
    });
  }

  HostsCompanion copyWith(
      {Value<int>? id,
      Value<String>? hostName,
      Value<String>? ip,
      Value<int>? version,
      Value<String>? readCommunityString,
      Value<String>? writeCommunityString,
      Value<String>? note}) {
    return HostsCompanion(
      id: id ?? this.id,
      hostName: hostName ?? this.hostName,
      ip: ip ?? this.ip,
      version: version ?? this.version,
      readCommunityString: readCommunityString ?? this.readCommunityString,
      writeCommunityString: writeCommunityString ?? this.writeCommunityString,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (hostName.present) {
      map['host_name'] = Variable<String>(hostName.value);
    }
    if (ip.present) {
      map['ip'] = Variable<String>(ip.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (readCommunityString.present) {
      map['read_community_string'] =
          Variable<String>(readCommunityString.value);
    }
    if (writeCommunityString.present) {
      map['write_community_string'] =
          Variable<String>(writeCommunityString.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HostsCompanion(')
          ..write('id: $id, ')
          ..write('hostName: $hostName, ')
          ..write('ip: $ip, ')
          ..write('version: $version, ')
          ..write('readCommunityString: $readCommunityString, ')
          ..write('writeCommunityString: $writeCommunityString, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $HostsTable extends Hosts with TableInfo<$HostsTable, Host> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HostsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _hostNameMeta = const VerificationMeta('hostName');
  @override
  late final GeneratedColumn<String?> hostName = GeneratedColumn<String?>(
      'host_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _ipMeta = const VerificationMeta('ip');
  @override
  late final GeneratedColumn<String?> ip = GeneratedColumn<String?>(
      'ip', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _versionMeta = const VerificationMeta('version');
  @override
  late final GeneratedColumn<int?> version = GeneratedColumn<int?>(
      'version', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(2));
  final VerificationMeta _readCommunityStringMeta =
      const VerificationMeta('readCommunityString');
  @override
  late final GeneratedColumn<String?> readCommunityString =
      GeneratedColumn<String?>('read_community_string', aliasedName, false,
          type: const StringType(),
          requiredDuringInsert: false,
          defaultValue: const Constant('public'));
  final VerificationMeta _writeCommunityStringMeta =
      const VerificationMeta('writeCommunityString');
  @override
  late final GeneratedColumn<String?> writeCommunityString =
      GeneratedColumn<String?>('write_community_string', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String?> note = GeneratedColumn<String?>(
      'note', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        hostName,
        ip,
        version,
        readCommunityString,
        writeCommunityString,
        note
      ];
  @override
  String get aliasedName => _alias ?? 'hosts';
  @override
  String get actualTableName => 'hosts';
  @override
  VerificationContext validateIntegrity(Insertable<Host> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('host_name')) {
      context.handle(_hostNameMeta,
          hostName.isAcceptableOrUnknown(data['host_name']!, _hostNameMeta));
    } else if (isInserting) {
      context.missing(_hostNameMeta);
    }
    if (data.containsKey('ip')) {
      context.handle(_ipMeta, ip.isAcceptableOrUnknown(data['ip']!, _ipMeta));
    } else if (isInserting) {
      context.missing(_ipMeta);
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    }
    if (data.containsKey('read_community_string')) {
      context.handle(
          _readCommunityStringMeta,
          readCommunityString.isAcceptableOrUnknown(
              data['read_community_string']!, _readCommunityStringMeta));
    }
    if (data.containsKey('write_community_string')) {
      context.handle(
          _writeCommunityStringMeta,
          writeCommunityString.isAcceptableOrUnknown(
              data['write_community_string']!, _writeCommunityStringMeta));
    } else if (isInserting) {
      context.missing(_writeCommunityStringMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Host map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Host.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $HostsTable createAlias(String alias) {
    return $HostsTable(attachedDatabase, alias);
  }
}

abstract class _$AppDB extends GeneratedDatabase {
  _$AppDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $HostsTable hosts = $HostsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [hosts];
}
