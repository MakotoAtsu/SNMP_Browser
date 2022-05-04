import 'package:snmp_browser/model/QueryResult.dart';
import 'package:snmp_browser/model/SnmpHost.dart';
import 'package:snmp_browser/store/reducer/StoredHostsReducer.dart';
import 'reducer/HistoryReducer.dart';
import 'reducer/PageIndexReducer.dart';
import 'reducer/TargetReducer.dart';

class AppState {
  final int pageIndex;
  final List<SnmpHost> storedHosts;
  final SnmpHost queryTarget;
  final List<QueryResult> histories;

  AppState(this.pageIndex, this.storedHosts, this.queryTarget, this.histories);

  static AppState Init() => AppState(0, [], SnmpHost(), []);
}

// MainReducer
AppState appStateReducer(AppState oldState, action) => AppState(
    pageIndexReducer(oldState.pageIndex, action),
    storeHostsReducer(oldState.storedHosts, action),
    queryTargetReducer(oldState.queryTarget, action),
    historyReducer(oldState.histories, action));
