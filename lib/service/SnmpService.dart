import 'package:dart_snmp/dart_snmp.dart';
import 'package:snmp_browser/model/HostModel.dart';
import 'package:snmp_browser/model/QueryResultModel.dart';
import 'package:snmp_browser/model/SnmpModel.dart';

class SnmpService {
  static Snmp? session;

  static Future<QueryResultModel> querySingleSnmpData(
    HostModel host,
    String oid,
    SnmpMethod method,
  ) async {
    Oid _oid = Oid.fromString(oid);
    session ??= await Snmp.createSession(host.ip!);

    if (session!.target != host.ip) {
      session = await Snmp.createSession(host.ip!);
    }
    QueryResultModel result;

    switch (method) {
      case SnmpMethod.get:
        var response = await session!.get(_oid);
        result = QueryResultModel.fromVarbind(response.pdu.varbinds.first);
        break;

      case SnmpMethod.walk:
      case SnmpMethod.getNext:
        var response = await session!.getNext(_oid);
        result = QueryResultModel.fromVarbind(response.pdu.varbinds.first);
        break;

      default:
        throw Exception('Snmp method not support');
    }

    if (!result.hasValue) {
      throw Exception(result.typeName);
    }

    return result;
  }
}
