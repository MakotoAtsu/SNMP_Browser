import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snmp_browser/widget/Pages/HistoryPage.dart';
import 'package:snmp_browser/widget/Pages/HostsPage.dart';

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
    return HistoryPage();
  }
}
