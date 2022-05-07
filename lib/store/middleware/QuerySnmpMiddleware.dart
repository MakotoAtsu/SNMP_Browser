import 'package:redux/redux.dart';
import 'package:snmp_browser/model/SnmpModel.dart';
import 'package:snmp_browser/service/SnmpService.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/store/reducer/HistoryReducer.dart';

class QuerySnmpMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is QuerySnmpAction) {
      action.items = [];

      if (action.method == SnmpMethod.walk) {
        var catchError = false;
        var count = 0;

        var nextOid = action.oid;

        do {
          try {
            action.items = [];
            action.items.add(await SnmpService.querySingleSnmpData(
              store.state.queryTarget,
              nextOid,
              action.method,
            ));

            count++;
            next(action);
            await Future.delayed(const Duration(milliseconds: 100));
            nextOid = action.items.first.oid;
          } catch (e) {
            catchError = true;
          }
        } while (count < 100);
        // action.onComplete?.call(action.items.last);
        return;
      } else {
        action.onExecuting?.call();
        try {
          action.items.add(await SnmpService.querySingleSnmpData(
            store.state.queryTarget,
            action.oid,
            action.method,
          ));
        } catch (e) {
          action.onError?.call(e);
          return;
        }
      }
      next(action);
      action.onComplete?.call(action.items.last);
      return;
    }

    next(action);
  }
}
