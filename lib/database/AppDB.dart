import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'entity/Host.dart';

part 'AppDB.g.dart';

@DriftDatabase(tables: [Hosts])
class AppDB extends _$AppDB {
  AppDB() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Host>> getAllHosts() => select(hosts).get();
  Future<Host?> getHostById(int id) =>
      (select(hosts)..where((x) => x.id.equals(id))).getSingleOrNull();
  Future<int> createHost(HostsCompanion entity) => into(hosts).insert(entity);
  Future<bool> updateHost(Host entity) => update(hosts).replace(entity);
  // Future deleteHost(Host entity) => delete(hosts).delete(entity);
  Future deleteHostById(int id) =>
      (delete(hosts)..where((h) => h.id.equals(id))).go();
}

LazyDatabase _openConnection() => LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();

      final file =
          File(path.join(dbFolder.path, 'SnmpMibBrowser', 'appDB.sqlite'));

      return NativeDatabase(file);
    });
