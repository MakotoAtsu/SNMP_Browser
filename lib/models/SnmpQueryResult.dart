import 'package:dart_snmp/dart_snmp.dart';

class SnmpQueryResult {
  final Oid oid;
  final String valueType;
  final String value;

  SnmpQueryResult(this.oid, this.valueType, this.value);
}
