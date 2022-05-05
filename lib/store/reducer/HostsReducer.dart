import 'package:redux/redux.dart';
import 'package:snmp_browser/model/HostModel.dart';

// Action
class FetchHostsAction {
  List<HostModel> storedHosts = [];
}

// Reducer
List<HostModel> fetchHostsReducer(
        List<HostModel> oldList, FetchHostsAction action) =>
    action.storedHosts;

// Combinen Reducer
Reducer<List<HostModel>> hostsReducer = combineReducers<List<HostModel>>(
    [TypedReducer<List<HostModel>, FetchHostsAction>(fetchHostsReducer)]);
