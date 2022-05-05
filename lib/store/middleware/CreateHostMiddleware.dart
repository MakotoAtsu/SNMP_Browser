import 'package:redux/redux.dart';
import 'package:snmp_browser/service/HostService.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/store/reducer/HostsReducer.dart';

class CreateHostMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is CreateHostAction) {
      action.onExecuting?.call();
      try {
        var hostId = await HostService.createHost(action.host);
        action.host.id = hostId;
      } catch (e) {
        action.onError?.call();
      }
      action.onComplete?.call();
    }
    next(action);
  }
}
