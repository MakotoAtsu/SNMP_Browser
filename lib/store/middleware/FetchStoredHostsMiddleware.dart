import 'dart:io';

import 'package:redux/redux.dart';
import 'package:snmp_browser/database/AppDB.dart';
import 'package:snmp_browser/model/SnmpHost.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/store/reducer/StoredHostsReducer.dart';

class FetchStoredHostsMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchStoredHostAction) {
      var allStoredHosts = await AppDB().getAllHosts();

      var data = allStoredHosts.map((db) {
        var h = SnmpHost();
        h.ip = InternetAddress.tryParse(db.ip);
        h.port = db.port;
        h.version = SnmpVersion.values[db.version];
        h.readCommunityString = db.readCommunityString;
        h.writeCommunityString = db.writeCommunityString;
        h.note = db.note;
        return h;
      }).toList();

      action.storedHosts = data;
    }
    next(action);
  }
}
