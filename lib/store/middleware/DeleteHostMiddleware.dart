import 'package:redux/redux.dart';
import 'package:snmp_browser/service/HostService.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/store/reducer/HostsReducer.dart';

class DeleteHostMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) {
    if (action is DeleteHostAction) {
      action.onExecuting?.call();
      HostService.deleteHostById(action.hostId)
          .then((value) => action.onComplete?.call())
          .onError((error, stackTrace) => action.onError?.call());
    }
    next(action);
  }
}
