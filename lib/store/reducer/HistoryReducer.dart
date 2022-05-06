import 'package:redux/redux.dart';
import 'package:snmp_browser/model/QueryResultModel.dart';
import 'package:snmp_browser/model/SnmpModel.dart';
import 'package:snmp_browser/store/reducer/interface/AsyncAction.dart';

// Action
class QuerySnmpAction extends AsyncAction {
  late final List<QueryResultModel> items;
  final String oid;
  final SnmpMethod method;
  QuerySnmpAction(this.oid, this.method,
      {Function? onExecuting, Function? onComplete, Function? onError})
      : super(
            onExecuting: onExecuting, onComplete: onComplete, onError: onError);
}

class RemoveHistoryAction {
  final int index;
  RemoveHistoryAction(this.index);
}

// Action Reducer
List<QueryResultModel> querySnmpReducer(
        List<QueryResultModel> oldList, QuerySnmpAction action) =>
    List.from(oldList)..addAll(action.items);

List<QueryResultModel> removeHistoryReducer(
        List<QueryResultModel> oldList, RemoveHistoryAction action) =>
    List.from(oldList)..removeAt(action.index);

// Combine Reducer
Reducer<List<QueryResultModel>> historyReducer =
    combineReducers<List<QueryResultModel>>([
  TypedReducer<List<QueryResultModel>, QuerySnmpAction>(querySnmpReducer),
  TypedReducer<List<QueryResultModel>, RemoveHistoryAction>(
      removeHistoryReducer)
]);
