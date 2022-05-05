import 'package:flutter/material.dart';
import 'package:snmp_browser/widget/Pages/HistoryPage.dart';
import 'package:snmp_browser/widget/Pages/HostListPage.dart';
import 'package:snmp_browser/widget/Pages/QueryPage.dart';

class BottomNaviBar extends StatelessWidget {
  final Map<String, BottomNavigationBarItem> _naviItems = const {
    HostListPage.pageRoute: BottomNavigationBarItem(
      icon: Icon(Icons.format_list_numbered),
      label: 'Hosts',
    ),
    QueryPage.pageRoute: BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Query',
    ),
    HistoryPage.pageRoute: BottomNavigationBarItem(
      icon: Icon(Icons.history),
      label: 'History',
    ),
  };

  @override
  Widget build(BuildContext context) {
    String? routeName = ModalRoute.of(context)!.settings.name;

    int currentPageIndex = 0;
    if (routeName != null) {
      currentPageIndex = _naviItems.keys.toList().indexOf(routeName);
      if (currentPageIndex < 0) currentPageIndex = 0;
    }

    var body = BottomNavigationBar(
      items: _naviItems.values.toList(),
      currentIndex: currentPageIndex,
      selectedItemColor: Colors.amber[800],
      onTap: (newIdx) {
        if (newIdx == currentPageIndex) return;

        var newRoute = _naviItems.keys.toList()[newIdx];
        Navigator.of(context).pushReplacementNamed(newRoute);
      },
    );

    return body;
  }
}
