import 'package:redux/redux.dart';

// Action
class UpdatePageIndexAction {
  final int index;
  UpdatePageIndexAction(this.index);
}

// Reducer
int updatePageIndexReducer(int oldIndex, UpdatePageIndexAction action) =>
    action.index;

// Combine Reducer
Reducer<int> pageIndexReducer = combineReducers<int>(
    [TypedReducer<int, UpdatePageIndexAction>(updatePageIndexReducer)]);
