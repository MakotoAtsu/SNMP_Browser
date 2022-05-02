import 'HistoryReducer.dart';
import 'TargetReducer.dart';

class AppState {
  final QueryTarget queryTarget;

  final List<QueryResult> histories;

  AppState(this.queryTarget, this.histories);
}

// MainReducer

AppState appStateReducer(AppState oldState, action) => AppState(
    QueryTargetReducer(oldState.queryTarget, action),
    historyReducer(oldState.histories, action));
