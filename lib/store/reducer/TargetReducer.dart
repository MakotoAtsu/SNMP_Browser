import 'package:redux/redux.dart';
import 'package:snmp_browser/model/SnmpHost.dart';

// Action
class UpdateQueryTargetAction {
  final SnmpHost target;
  UpdateQueryTargetAction(this.target);
}

// Reducer
SnmpHost updateTargetReducer(
        SnmpHost oldTarget, UpdateQueryTargetAction action) =>
    action.target;

Reducer<SnmpHost> queryTargetReducer = combineReducers<SnmpHost>(
    [TypedReducer<SnmpHost, UpdateQueryTargetAction>(updateTargetReducer)]);
