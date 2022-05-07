import 'package:dart_snmp/dart_snmp.dart';
import 'package:snmp_browser/model/HostModel.dart';
import 'package:snmp_browser/model/QueryResultModel.dart';
import 'package:snmp_browser/model/SnmpModel.dart';

class SnmpService {
  static Snmp? session;

  static Future<List<QueryResultModel>> querySnmpData(
    HostModel host,
    String oid,
    SnmpMethod method,
  ) async {
    Oid _oid = Oid.fromString(oid);
    session ??= await Snmp.createSession(host.ip!);

    if (session!.target != host.ip) {
      session = await Snmp.createSession(host.ip!);
    }
    List<QueryResultModel> result;

    switch (method) {
      case SnmpMethod.get:
        var response = await session!.get(_oid);

        result = response.pdu.varbinds
            .map((e) => QueryResultModel.fromVarbind(e))
            .toList();
        break;

      case SnmpMethod.walk:
      case SnmpMethod.getNext:
        var response = await session!.getNext(_oid);
        result = response.pdu.varbinds
            .map((e) => QueryResultModel.fromVarbind(e))
            .toList();
        break;

      default:
        throw Exception('Snmp method not support');
    }

    if (!result.first.hasValue) {
      throw Exception(result.first.typeName);
    }

    return result;
  }

  static Future<List<QueryResultModel>> _walk(
      Snmp session, Oid beginOid) async {
    List<QueryResultModel> list = [];

    bool hasNext = true;

    do {
      var message = await session.getNext(beginOid);
      var data = QueryResultModel.fromVarbind(message.pdu.varbinds.first);
      if (data.type == VarbindType.EndOfMibView) {
        hasNext = false;
      }
      list.add(data);
    } while (hasNext);

    return list;
  }
}
