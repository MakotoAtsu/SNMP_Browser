import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/widget/Pages/HistoryPage.dart';
import 'package:snmp_browser/widget/Pages/HostListPage.dart';
import 'package:snmp_browser/widget/Pages/QueryPage.dart';

class BottomNaviBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? routeName = ModalRoute.of(context)!.settings.name;
    var store = StoreProvider.of<AppState>(context);

    var canQuery = store.state.queryPageStatus.queryTarget.isValid;

    var isBusy = store.state.queryPageStatus.isBusy;

    var naviItems = {
      HostListPage.pageRoute: BottomNavigationBarItem(
        icon: Icon(
          Icons.format_list_numbered,
          color: isBusy ? Colors.black12 : null,
        ),
        label: 'Hosts',
      ),
      // ignore: prefer_const_constructors
      QueryPage.pageRoute: BottomNavigationBarItem(
        icon: Icon(
          Icons.search,
          color: canQuery ? null : Colors.black12,
        ),
        label: 'Query',
      ),
      HistoryPage.pageRoute: BottomNavigationBarItem(
        icon: Icon(
          Icons.history,
          color: isBusy ? Colors.black12 : null,
        ),
        label: 'History',
      ),
    };

    int currentPageIndex = 0;
    if (routeName != null) {
      currentPageIndex = naviItems.keys.toList().indexOf(routeName);
      if (currentPageIndex < 0) currentPageIndex = 0;
    }

    var body = StoreConnector<AppState, bool>(
        converter: (store) => store.state.queryPageStatus.isBusy,
        builder: (context, isBusy) {
          return BottomNavigationBar(
            currentIndex: currentPageIndex,
            items: naviItems.values.toList(),
            selectedItemColor: Colors.amber[800],
            onTap: (newIdx) {
              if (isBusy) return;
              if (newIdx == currentPageIndex) return;
              var newRoute = naviItems.keys.toList()[newIdx];

              if (newRoute == QueryPage.pageRoute && !canQuery) {
                return;
              }
              Navigator.of(context).pushReplacementNamed(newRoute);
            },
          );
        });

    return body;
  }
}
