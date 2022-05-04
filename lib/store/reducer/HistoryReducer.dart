import 'package:redux/redux.dart';
import 'package:snmp_browser/model/QueryResult.dart';

// Action
class AppendQueryResultAction {
  final QueryResult item;
  AppendQueryResultAction(this.item);
}

class RemoveQueryResultAction {
  final int index;
  RemoveQueryResultAction(this.index);
}

// Action Reducer
List<QueryResult> appendQueryReducer(
    List<QueryResult> oldList, AppendQueryResultAction action) {
  List<QueryResult> newList = List.from(oldList);
  newList.add(action.item);
  return newList;
}

List<QueryResult> removeQueryReducer(
    List<QueryResult> oldList, RemoveQueryResultAction action) {
  List<QueryResult> newList = List.from(oldList);
  newList.removeAt(action.index);
  return newList;
}

// Combine Reducer
Reducer<List<QueryResult>> historyReducer = combineReducers<List<QueryResult>>([
  TypedReducer<List<QueryResult>, AppendQueryResultAction>(appendQueryReducer),
  TypedReducer<List<QueryResult>, RemoveQueryResultAction>(removeQueryReducer)
]);

// List<QueryResult> queryResultReducerOld(List<QueryResult> oldList, action) {
//   if (action is AppendQueryResultAction) {
//     return appendQueryReducer(oldList, action);
//   }
//   if (action is RemoveQueryResultAction) {
//     return removeQueryReducer(oldList, action);
//   }
//   return oldList;
// }
