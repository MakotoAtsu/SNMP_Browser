import 'package:drift/drift.dart';

class Hosts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get hostName => text()();
  TextColumn get ip => text()();
  IntColumn get port => integer().withDefault(const Constant(161))();
  IntColumn get version => integer().withDefault(const Constant(2))();
  TextColumn get readCommunityString =>
      text().withDefault(const Constant('public'))();
  TextColumn get writeCommunityString =>
      text().withDefault(const Constant(''))();
  TextColumn get note => text().withDefault(const Constant(''))();
}
