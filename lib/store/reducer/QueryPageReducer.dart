import 'package:redux/redux.dart';
import 'package:snmp_browser/model/HostModel.dart';
import 'package:snmp_browser/model/SnmpModel.dart';
import 'TargetReducer.dart';

class QueryPageStatus {
  final bool isBusy;
  final HostModel queryTarget;
  final String currentQueryOID;
  final SnmpMethod currentSnmpMethod;

  QueryPageStatus.init(
    this.queryTarget,
    this.currentQueryOID,
    this.currentSnmpMethod,
    this.isBusy,
  );

  QueryPageStatus(QueryPageStatus oldState, action)
      : queryTarget = queryTargetReducer(oldState.queryTarget, action),
        currentQueryOID =
            currentQueryOidReducer(oldState.currentQueryOID, action),
        currentSnmpMethod =
            currentSnmpMethodReducer(oldState.currentSnmpMethod, action),
        isBusy = queryingFlagReducer(oldState.isBusy, action);
}

// Action
class UpdateQueryingFlagAction {
  final bool isQuerying;
  UpdateQueryingFlagAction(this.isQuerying);
}

class UpdateCurrentQueryOIDAction {
  final String oid;
  UpdateCurrentQueryOIDAction(this.oid);
}

class UpdateCurrentSnmpMethodAction {
  final SnmpMethod snmpMethod;
  UpdateCurrentSnmpMethodAction(this.snmpMethod);
}

// Reducer
bool updateQueryingFlagReducer(
        bool oldStatus, UpdateQueryingFlagAction action) =>
    action.isQuerying;

String updateCurrentQueryOidReducer(
        String old, UpdateCurrentQueryOIDAction action) =>
    action.oid;

SnmpMethod updateCurrentSnmpMethodReducer(
        SnmpMethod old, UpdateCurrentSnmpMethodAction action) =>
    action.snmpMethod;

// ConbineReducer
Reducer<bool> queryingFlagReducer = combineReducers<bool>([
  TypedReducer<bool, UpdateQueryingFlagAction>(updateQueryingFlagReducer),
]);

Reducer<String> currentQueryOidReducer = combineReducers<String>([
  TypedReducer<String, UpdateCurrentQueryOIDAction>(
      updateCurrentQueryOidReducer)
]);

Reducer<SnmpMethod> currentSnmpMethodReducer = combineReducers<SnmpMethod>([
  TypedReducer<SnmpMethod, UpdateCurrentSnmpMethodAction>(
      updateCurrentSnmpMethodReducer)
]);
