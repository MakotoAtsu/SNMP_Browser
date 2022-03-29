import 'dart:io';
import 'package:dart_snmp/dart_snmp.dart';
import 'package:snmp_browser/models/SnmpQueryResult.dart';

class SnmpUtility {
  final InternetAddress targetIp;
  Snmp? snmpTarget;

  SnmpUtility(this.targetIp);

  Future checkConnected() async {
    snmpTarget ??= await Snmp.createSession(targetIp);
  }

  Future<SnmpQueryResult> getNext(Oid oid) async {
    await checkConnected();
    var response = await snmpTarget?.getNext(oid);
    if (response == null) {
      throw NoConnectedError(targetIp);
    }
    var result = _parseResult(response.pdu.varbinds.first);
    return result;
  }

  Future<SnmpQueryResult> get(Oid oid) async {
    await checkConnected();
    var response = await snmpTarget?.get(oid);
    if (response == null) {
      throw NoConnectedError(targetIp);
    }

    var result = _parseResult(response.pdu.varbinds.first);
    return result;
  }

  SnmpQueryResult _parseResult(Varbind bind) {
    return SnmpQueryResult(bind.oid,
        VarbindType.typeNames[bind.tag] ?? 'Unknown', bind.value.toString());
  }
}

class NoConnectedError extends Error {
  final InternetAddress target;

  NoConnectedError(this.target);

  @override
  String toString() {
    return 'Snmp target : $target not connect yet';
  }
}
