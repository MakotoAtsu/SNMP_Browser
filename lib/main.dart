import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/widget/Pages/CreateAndEditHostPage.dart';
import 'package:snmp_browser/widget/Pages/HistoryPage.dart';
import 'package:snmp_browser/widget/Pages/HostListPage.dart';
import 'package:snmp_browser/widget/Pages/QueryPage.dart';
import 'package:redux/redux.dart';

import 'store/middleware/FetchHostsMiddleware.dart';

void main() async {
  final List<Middleware<AppState>> middlewares = [FetchHostsMiddleware()];
  final appStore = Store<AppState>(appStateReducer,
      initialState: AppState.Init(), middleware: middlewares);

  runApp(SNMPBrowser(appStore));
}

class SNMPBrowser extends StatelessWidget {
  final Store<AppState> appStore;
  SNMPBrowser(this.appStore, {Key? key}) : super(key: key);

  final Map<String, WidgetBuilder> _routerSetting = {
    HostListPage.pageRoute: (context) => HostListPage(),
    QueryPage.pageRoute: (context) => QueryPage(),
    HistoryPage.pageRoute: (context) => HistoryPage(),
    CreateAndEditHostPage.pageRoute: (context) => CreateAndEditHostPage()
  };

  @override
  Widget build(BuildContext context) {
    var app = MaterialApp(
      title: 'SNMP Browser',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: HostListPage.pageRoute,
      routes: _routerSetting,
    );

    var storeProvider = StoreProvider(store: appStore, child: app);
    return storeProvider;
  }
}
