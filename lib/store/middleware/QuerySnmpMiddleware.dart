import 'package:redux/redux.dart';
import 'package:snmp_browser/model/SnmpModel.dart';
import 'package:snmp_browser/service/SnmpService.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/store/reducer/HistoryReducer.dart';
import 'package:snmp_browser/store/reducer/QueryPageReducer.dart';

class QuerySnmpMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is QuerySnmpAction) {
      action.items = [];

      if (action.method == SnmpMethod.walk) {
        await _multiQuery(store, action, next);
      } else {
        await _singleQuery(store, action, next);
      }
    }

    next(action);
  }

  Future _singleQuery(
    Store<AppState> store,
    QuerySnmpAction action,
    NextDispatcher next,
  ) async {
    action.onExecuting?.call();

    next(UpdateQueryingFlagAction(true));

    try {
      action.items.add(await SnmpService.querySingleSnmpData(
        store.state.queryPageStatus.queryTarget,
        action.oid,
        action.method,
      ));

      next(UpdateQueryingFlagAction(false));
      action.onComplete?.call(action.items.last);
    } catch (e) {
      action.onError?.call(e);
    }
  }

  Future _multiQuery(
    Store<AppState> store,
    QuerySnmpAction action,
    NextDispatcher next,
  ) async {
    action.onExecuting?.call();
    next(UpdateQueryingFlagAction(true));
    var hasNext = true;
    var count = 0;

    var nextOid = action.oid;

    do {
      action.items = [];

      try {
        action.items.add(await SnmpService.querySingleSnmpData(
          store.state.queryPageStatus.queryTarget,
          nextOid,
          action.method,
        ));
      } catch (e) {
        hasNext = false;
      }

      count++;
      nextOid = action.items.first.oid; // Update next oid
      next(action); // Update Result

      await Future.delayed(const Duration(milliseconds: 100));
    } while (count < 100);

    next(UpdateQueryingFlagAction(false));

    action.onComplete?.call();
  }
}
