import 'dart:io';
import 'package:dart_snmp/dart_snmp.dart';

// Store
class AppState {
  List<History> queryHistory = [];
  SnmpTarget snmpTarget = SnmpTarget(InternetAddress("127.0.0.1"));
  QueryInfo queryInfo = QueryInfo();

  AppState({List<History>? history, SnmpTarget? target, QueryInfo? info}) {
    queryHistory = history ?? [];
    snmpTarget = target ?? SnmpTarget(InternetAddress('127.0.0.1'));
    queryInfo = info ?? QueryInfo();
  }

  AppState clone() {
    var newState = AppState.fromJson(toJson());
    return newState;
  }

  AppState.fromJson(Map<String, dynamic> json)
      : queryHistory = json['q_history'];

  Map<String, dynamic> toJson() => {'q_history': queryHistory};
}

class History {
  String oid;
  String value;

  History(this.oid, this.value);

  History.fromJson(Map<String, dynamic> json)
      : oid = json['oid'],
        value = json['value'];

  Map<String, dynamic> toJso() => {'oid': oid, 'value': value};
}

class SnmpTarget {
  InternetAddress ipAddress;
  int? port;
  SnmpVersion version = SnmpVersion.V2c;
  String readCommunity = "public";
  // String? writeCommunity;

  SnmpTarget(this.ipAddress);

  SnmpTarget.fromJson(Map<String, dynamic> json)
      : ipAddress = json['ip_address'],
        port = json['port'],
        version = json['version'],
        readCommunity = json['read_community'];

  Map<String, dynamic> toJson() => {
        'ip_address': ipAddress,
        'port': port,
        'version': version,
        'read_community': readCommunity
      };
}

class QueryInfo {
  QueryMethod method = QueryMethod.GET;
  String oid = "1.3.6.1.2.1.1.1.0";

  QueryInfo();

  QueryInfo.fromJson(Map<String, dynamic> json)
      : method = json['method'],
        oid = json['oid'];

  Map<String, dynamic> toJson() => {'method': method, 'oid': oid};
}

// ignore: constant_identifier_names
enum QueryMethod { GET, GET_NEXT, GET_BULK, WALK }

// Action
class AddQueryHistort {
  Message message;
  AddQueryHistort(this.message);
}

class RemoveQueryHistory {
  int historyIndex;
  RemoveQueryHistory(this.historyIndex);
}

class UpdateSnmpTarget {
  SnmpTarget target;
  UpdateSnmpTarget(this.target);
}

class UpdateQueryInfo {
  QueryInfo info;
  UpdateQueryInfo(this.info);
}

// Reducer
AppState appStateReducer(AppState oldState, dynamic param) {
  var newState = oldState.clone();

  switch (param.runtimeType) {
    case AddQueryHistort:
      (param as AddQueryHistort).message.pdu.varbinds.forEach((element) {
        var oid = element.oid.identifier ?? "";
        if (oid == "") return;
        newState.queryHistory.add(History(oid, element.value));
      });
      break;
    case RemoveQueryHistory:
      newState.queryHistory
          .removeAt((param as RemoveQueryHistory).historyIndex);
      break;

    case UpdateQueryInfo:
      newState.queryInfo = (param as UpdateQueryInfo).info;
      break;
    case UpdateSnmpTarget:
      newState.snmpTarget = (param as UpdateSnmpTarget).target;
      break;
    default:
      break;
  }

  return newState;
}
