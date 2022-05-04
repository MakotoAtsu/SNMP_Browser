import 'package:redux/redux.dart';
import 'package:snmp_browser/model/SnmpHost.dart';

// Action
class FetchStoredHostAction {
  List<SnmpHost> storedHosts = [];
}

// Reducer
List<SnmpHost> fetchStoredHostsReducer(
        List<SnmpHost> oldList, FetchStoredHostAction action) =>
    action.storedHosts;

// Combinen Reducer
Reducer<List<SnmpHost>> storeHostsReducer = combineReducers<List<SnmpHost>>([
  TypedReducer<List<SnmpHost>, FetchStoredHostAction>(fetchStoredHostsReducer)
]);
