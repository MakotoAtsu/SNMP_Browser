import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snmp_browser/widget/Pages/HistoryPage.dart';
import 'package:snmp_browser/widget/Pages/HostsPage.dart';
import '../store/AppState.dart';
import 'Compoments/BottomNavi.dart';

class Home extends StatelessWidget {
  Widget getRenderPage(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return HostsPage();
      case 2:
        return HistoryPage();
    }

    return HostsPage();
  }

  @override
  Widget build(BuildContext context) {
    var body = StoreConnector<AppState, int>(
        converter: (store) => store.state.pageIndex,
        builder: (context, pageIdx) => getRenderPage(pageIdx));
    return body;
  }
}
