import 'package:redux/redux.dart';
import 'package:snmp_browser/service/HostService.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/store/reducer/HostsReducer.dart';

class FetchHostsMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchHostsAction) {
      action.onExecuting?.call();
      try {
        var hosts = await HostService.getAllHostFromDB();
        action.hosts = hosts;
      } catch (e) {
        action.onError?.call();
      }
      action.onComplete?.call();
    }

    next(action);
  }
}
