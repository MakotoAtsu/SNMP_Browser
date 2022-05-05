import 'package:redux/redux.dart';
import 'package:snmp_browser/model/HostModel.dart';
import 'package:snmp_browser/store/reducer/interface/AsyncAction.dart';

// Action
class FetchHostsAction extends AsyncAction {
  List<HostModel> hosts = [];

  FetchHostsAction({
    this.hosts = const [],
    Function? onExecuting,
    Function? onComplete,
    Function? onError,
  }) : super(
            onExecuting: onExecuting, onComplete: onComplete, onError: onError);
}

class UpdateHostAction extends AsyncAction {
  final HostModel host;

  UpdateHostAction(
    this.host, {
    Function? onExecuting,
    Function? onComplete,
    Function? onError,
  }) : super(
            onExecuting: onExecuting, onComplete: onComplete, onError: onError);
}

class DeleteHostAction extends AsyncAction {
  late final int hostId;

  DeleteHostAction(this.hostId,
      {Function? onExecuting, Function? onComplete, Function? onError})
      : super(
            onExecuting: onExecuting, onComplete: onComplete, onError: onError);

  DeleteHostAction.fromHost(HostModel model,
      {Function? onExecuting, Function? onComplete, Function? onError})
      : super(
            onExecuting: onExecuting,
            onComplete: onComplete,
            onError: onError) {
    hostId = model.id!;
  }
}

class CreateHostAction extends AsyncAction {
  final HostModel host;

  CreateHostAction(this.host,
      {Function? onExecuting, Function? onComplete, Function? onError})
      : super(
            onExecuting: onExecuting, onComplete: onComplete, onError: onError);
}

// Reducer
List<HostModel> fetchHostsReducer(
        List<HostModel> oldList, FetchHostsAction action) =>
    action.hosts;

List<HostModel> updateHostReducer(
    List<HostModel> oldList, UpdateHostAction action) {
  var newList = List<HostModel>.from(oldList);
  if (newList.any((x) => x.id == action.host.id)) {
    newList[newList.indexWhere((h) => h.id == action.host.id)] = action.host;
    return newList;
  } else {
    return oldList;
  }
}

List<HostModel> createHostReducer(
        List<HostModel> oldList, CreateHostAction action) =>
    List<HostModel>.from(oldList)..add(action.host);

List<HostModel> deleteHostReducer(
        List<HostModel> oldList, DeleteHostAction action) =>
    List<HostModel>.from(oldList)..removeWhere((h) => h.id == action.hostId);

// Combinen Reducer
Reducer<List<HostModel>> hostsReducer = combineReducers<List<HostModel>>([
  TypedReducer<List<HostModel>, FetchHostsAction>(fetchHostsReducer),
  TypedReducer<List<HostModel>, UpdateHostAction>(updateHostReducer),
  TypedReducer<List<HostModel>, DeleteHostAction>(deleteHostReducer),
  TypedReducer<List<HostModel>, CreateHostAction>(createHostReducer),
]);
