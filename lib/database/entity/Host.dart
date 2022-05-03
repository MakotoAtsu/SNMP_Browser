import 'package:drift/drift.dart';

class Hosts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get hostName => text().withLength(min: 1, max: 50)();
  TextColumn get ip => text()();
  IntColumn get version => integer().withDefault(const Constant(2))();
  TextColumn get readCommunityString =>
      text().withDefault(const Constant('public'))();
  TextColumn get writeCommunityString => text()();
  TextColumn get note => text()();
}
