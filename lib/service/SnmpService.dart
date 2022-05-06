import 'dart:io';

import 'package:dart_snmp/dart_snmp.dart';
import 'package:snmp_browser/model/HostModel.dart';
import 'package:snmp_browser/model/QueryResultModel.dart';
import 'package:snmp_browser/model/SnmpModel.dart';

class SnmpService {
  static Iterable<QueryResultModel> _convertToResultModel(Message msg) =>
      msg.pdu.varbinds.map((e) => QueryResultModel(
            e.oid.toString(),
            e.tag,
            e.value.toString(),
          ));

  static Future<List<QueryResultModel>> querySnmpData(
    HostModel host,
    String oid,
    SnmpMethod method,
  ) async {
    Oid _oid = Oid.fromString(oid);
    var session = await Snmp.createSession(host.ip!);

    List<QueryResultModel> result = [];
    switch (method) {
      case SnmpMethod.get:
        var response = await session.get(_oid);
        result.addAll(_convertToResultModel(response));
        break;
      case SnmpMethod.getNext:
        var response = await session.getNext(_oid);
        result.addAll(_convertToResultModel(response));
        break;
      default:
    }

    return result;
  }
}
