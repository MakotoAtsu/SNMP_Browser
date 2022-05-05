import 'package:snmp_browser/model/QueryResultModel.dart';
import 'package:snmp_browser/model/HostModel.dart';
import 'package:snmp_browser/store/reducer/StoredHostsReducer.dart';
import 'reducer/HistoryReducer.dart';
import 'reducer/TargetReducer.dart';

class AppState {
  final List<HostModel> storedHosts;
  final HostModel queryTarget;
  final List<QueryResultModel> histories;

  AppState(this.storedHosts, this.queryTarget, this.histories);

  static AppState Init() => AppState([], HostModel(), []);
}

// MainReducer
AppState appStateReducer(AppState oldState, action) => AppState(
    storeHostsReducer(oldState.storedHosts, action),
    queryTargetReducer(oldState.queryTarget, action),
    historyReducer(oldState.histories, action));
