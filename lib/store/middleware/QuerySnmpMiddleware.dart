import 'package:redux/redux.dart';
import 'package:snmp_browser/service/SnmpService.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/store/reducer/HistoryReducer.dart';

class QuerySnmpMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is QuerySnmpAction) {
      action.onExecuting?.call();

      try {
        action.items = await SnmpService.querySnmpData(
          store.state.queryTarget,
          action.oid,
          action.method,
        );
        action.onComplete?.call(action.items.last);
      } catch (e) {
        action.onError?.call(e);
        return;
      }
      next(action);
      // return action.items.last;
    }

    next(action);
  }
}
