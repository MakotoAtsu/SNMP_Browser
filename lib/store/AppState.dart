import 'package:redux/redux.dart';
import 'package:snmp_browser/model/QueryResultModel.dart';
import 'package:snmp_browser/model/HostModel.dart';
import 'package:snmp_browser/store/middleware/CreateHostMiddleware.dart';
import 'package:snmp_browser/store/middleware/DeleteHostMiddleware.dart';
import 'package:snmp_browser/store/middleware/UpdateHostMiddleware.dart';
import 'package:snmp_browser/store/reducer/HostsReducer.dart';
import 'middleware/FetchHostsMiddleware.dart';
import 'middleware/QuerySnmpMiddleware.dart';
import 'reducer/HistoryReducer.dart';
import 'reducer/TargetReducer.dart';

class AppState {
  final List<HostModel> hosts;
  final HostModel queryTarget;
  final List<QueryResultModel> histories;

  AppState(this.hosts, this.queryTarget, this.histories);

  static AppState init() => AppState([], HostModel(), []);
}

List<Middleware<AppState>> getAllMiddleware = [
  QuerySnmpMiddleware(),
  FetchHostsMiddleware(),
  DeleteHostMiddleware(),
  UpdateHostMiddleware(),
  CreateHostMiddleware(),
];

// MainReducer
AppState appStateReducer(AppState oldState, action) => AppState(
    hostsReducer(oldState.hosts, action),
    queryTargetReducer(oldState.queryTarget, action),
    historyReducer(oldState.histories, action));
