import 'package:dart_snmp/dart_snmp.dart';

class QueryResultModel {
  final String oid;
  final int tag;
  final String value;
  VarbindType get type => VarbindType.fromInt(tag);
  String get typeName => type.name;
  bool get hasValue =>
      type != VarbindType.NoSuchInstance &&
      type != VarbindType.NoSuchObject &&
      type != VarbindType.EndOfMibView;

  QueryResultModel(this.oid, this.tag, this.value);

  QueryResultModel.fromVarbind(Varbind varbind)
      : oid = varbind.oid.identifier!,
        tag = varbind.tag,
        value = varbind.value.toString();
}
