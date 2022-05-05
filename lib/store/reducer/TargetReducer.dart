import 'package:redux/redux.dart';
import 'package:snmp_browser/model/HostModel.dart';

// Action
class UpdateQueryTargetAction {
  final HostModel target;
  UpdateQueryTargetAction(this.target);
}

// Reducer
HostModel updateTargetReducer(
        HostModel oldTarget, UpdateQueryTargetAction action) =>
    action.target;

Reducer<HostModel> queryTargetReducer = combineReducers<HostModel>(
    [TypedReducer<HostModel, UpdateQueryTargetAction>(updateTargetReducer)]);
