import 'package:snmp_browser/store/PageIndexReducer.dart';

import 'HistoryReducer.dart';
import 'TargetReducer.dart';

class AppState {
  final int pageIndex;
  final QueryTarget queryTarget;
  final List<QueryResult> histories;

  AppState(this.pageIndex, this.queryTarget, this.histories);
}

// MainReducer

AppState appStateReducer(AppState oldState, action) => AppState(
    pageIndexReducer(oldState.pageIndex, action),
    queryTargetReducer(oldState.queryTarget, action),
    historyReducer(oldState.histories, action));
