import 'package:redux/redux.dart';
import 'package:snmp_browser/model/HostModel.dart';

// Action
class FetchStoredHostAction {
  List<HostModel> storedHosts = [];
}

// Reducer
List<HostModel> fetchStoredHostsReducer(
        List<HostModel> oldList, FetchStoredHostAction action) =>
    action.storedHosts;

// Combinen Reducer
Reducer<List<HostModel>> storeHostsReducer = combineReducers<List<HostModel>>([
  TypedReducer<List<HostModel>, FetchStoredHostAction>(fetchStoredHostsReducer)
]);
