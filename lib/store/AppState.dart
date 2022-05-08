import 'package:redux/redux.dart';
import 'package:snmp_browser/model/QueryResultModel.dart';
import 'package:snmp_browser/model/HostModel.dart';
import 'package:snmp_browser/model/SnmpModel.dart';
import 'package:snmp_browser/store/middleware/CreateHostMiddleware.dart';
import 'package:snmp_browser/store/middleware/DeleteHostMiddleware.dart';
import 'package:snmp_browser/store/middleware/UpdateHostMiddleware.dart';
import 'package:snmp_browser/store/reducer/HostsReducer.dart';
import 'package:snmp_browser/store/reducer/QueryPageReducer.dart';
import 'middleware/FetchHostsMiddleware.dart';
import 'middleware/QuerySnmpMiddleware.dart';
import 'reducer/HistoryReducer.dart';

class AppState {
  final List<HostModel> hosts;
  final List<QueryResultModel> histories;
  final QueryPageStatus queryPageStatus;

  AppState(this.hosts, this.queryPageStatus, this.histories);

  static AppState init() => AppState([],
      QueryPageStatus.init(HostModel(), '1.3', SnmpMethod.getNext, false), []);
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
    QueryPageStatus(oldState.queryPageStatus, action),
    historyReducer(oldState.histories, action));
