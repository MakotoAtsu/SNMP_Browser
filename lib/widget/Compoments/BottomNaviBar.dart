import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/widget/Pages/HistoryPage.dart';
import 'package:snmp_browser/widget/Pages/HostListPage.dart';
import 'package:snmp_browser/widget/Pages/QueryPage.dart';

class BottomNaviBar extends StatelessWidget {
  final Map<String, BottomNavigationBarItem> _naviItems = {
    HostListPage.pageRoute: const BottomNavigationBarItem(
      icon: Icon(Icons.format_list_numbered),
      label: 'Hosts',
    ),
    // ignore: prefer_const_constructors
    QueryPage.pageRoute: BottomNavigationBarItem(
      icon: const Icon(Icons.search),
      label: 'Query',
    ),
    HistoryPage.pageRoute: const BottomNavigationBarItem(
      icon: Icon(Icons.history),
      label: 'History',
    ),
  };

  @override
  Widget build(BuildContext context) {
    String? routeName = ModalRoute.of(context)!.settings.name;

    var canQuery =
        !StoreProvider.of<AppState>(context).state.queryTarget.isValid;

    if (canQuery) {
      _naviItems[QueryPage.pageRoute] = const BottomNavigationBarItem(
        icon: Icon(
          Icons.search,
          color: Colors.black12,
        ),
        label: 'Query',
      );
    }

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

        if (newRoute == QueryPage.pageRoute && canQuery) {
          return;
        }
        Navigator.of(context).pushReplacementNamed(newRoute);
      },
    );

    return body;
  }
}
