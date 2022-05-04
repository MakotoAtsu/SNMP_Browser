import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snmp_browser/database/AppDB.dart';
import 'package:snmp_browser/model/SnmpHost.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/store/reducer/StoredHostsReducer.dart';
import 'package:snmp_browser/widget/Compoments/BottomNavi.dart';
import 'package:snmp_browser/widget/Compoments/TopBar.dart';

class HostsPage extends StatelessWidget {
  Future doSomthing(BuildContext context) async {
    var db = AppDB();
    var currentCount = (await db.getAllHosts()).length;

    var host = const HostsCompanion(
        hostName: Value('TestHost_1'), ip: Value('192.168.1.1'));

    await db.createHost(host);
    StoreProvider.of<AppState>(context).dispatch(FetchStoredHostAction());
  }

  @override
  Widget build(BuildContext context) {
    var body = StoreConnector<AppState, List<SnmpHost>>(
        converter: (store) => store.state.storedHosts,
        onInit: (store) => store.dispatch(FetchStoredHostAction()),
        builder: (context, storedHosts) => Scaffold(
              appBar: TopBar(),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add_box_outlined),
                onPressed: () async {
                  doSomthing(context);
                },
              ),
              body: Center(
                  child: Text("Host Count : " + storedHosts.length.toString())),
              bottomNavigationBar: BottomNaviBar(),
            ));

    return body;
  }
}
