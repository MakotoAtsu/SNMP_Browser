import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/store/reducer/PageIndexReducer.dart';

class BottomNaviBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);

    var body = StoreConnector<AppState, int>(
        converter: (store) => store.state.pageIndex,
        builder: (context, pageIdx) => BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.format_list_numbered),
                  label: 'Hosts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Query',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'History',
                ),
              ],
              currentIndex: pageIdx,
              selectedItemColor: Colors.amber[800],
              onTap: (newIdx) {
                if (newIdx == pageIdx) return;
                store.dispatch(UpdatePageIndexAction(newIdx));
              },
            ));

    return body;
  }
}
