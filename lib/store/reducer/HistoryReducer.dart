import 'package:redux/redux.dart';
import 'package:snmp_browser/model/QueryResultModel.dart';

// Action
class AppendQueryResultAction {
  final QueryResultModel item;
  AppendQueryResultAction(this.item);
}

class RemoveQueryResultAction {
  final int index;
  RemoveQueryResultAction(this.index);
}

// Action Reducer
List<QueryResultModel> appendQueryReducer(
    List<QueryResultModel> oldList, AppendQueryResultAction action) {
  List<QueryResultModel> newList = List.from(oldList);
  newList.add(action.item);
  return newList;
}

List<QueryResultModel> removeQueryReducer(
    List<QueryResultModel> oldList, RemoveQueryResultAction action) {
  List<QueryResultModel> newList = List.from(oldList);
  newList.removeAt(action.index);
  return newList;
}

// Combine Reducer
Reducer<List<QueryResultModel>> historyReducer =
    combineReducers<List<QueryResultModel>>([
  TypedReducer<List<QueryResultModel>, AppendQueryResultAction>(
      appendQueryReducer),
  TypedReducer<List<QueryResultModel>, RemoveQueryResultAction>(
      removeQueryReducer)
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
