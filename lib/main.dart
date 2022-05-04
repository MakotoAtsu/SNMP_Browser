import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/store/middleware/fetchStoredHostsMiddleware.dart';
import 'package:snmp_browser/widget/home.dart';
import 'package:redux/redux.dart';

void main() async {
  final List<Middleware<AppState>> middlewares = [FetchStoredHostsMiddleware()];
  final appStore = Store<AppState>(appStateReducer,
      initialState: AppState.Init(), middleware: middlewares);

  runApp(SNMPBrowser(appStore));
}

class SNMPBrowser extends StatelessWidget {
  final Store<AppState> appStore;
  const SNMPBrowser(this.appStore, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var app = MaterialApp(
      title: 'SNMP Browser',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(),
    );
    var storeProvider = StoreProvider(store: appStore, child: app);
    return storeProvider;
  }
}
