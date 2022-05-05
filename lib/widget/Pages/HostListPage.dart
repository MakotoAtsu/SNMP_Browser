import 'package:flutter/material.dart';
import 'package:snmp_browser/widget/Compoments/BottomNaviBar.dart';
import 'package:snmp_browser/widget/Pages/CreateAndEditHostPage.dart';

class HostListPage extends StatelessWidget {
  static const String pageName = 'Hosts';
  static const String pageRoute = '/Hosts';

  @override
  Widget build(BuildContext context) {
    var body = Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Hosts')),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Create',
            onPressed: () {
              Navigator.of(context).pushNamed(CreateAndEditHostPage.pageRoute);
            },
          )
        ],
      ),
      body: const Center(child: Text("Host Count : ")),
      bottomNavigationBar: BottomNaviBar(),
    );

    return body;
  }
}
