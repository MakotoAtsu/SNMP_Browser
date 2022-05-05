import 'package:flutter/material.dart';
import 'package:snmp_browser/widget/Compoments/BottomNaviBar.dart';
import 'package:snmp_browser/widget/Compoments/TopBar.dart';

class QueryPage extends StatelessWidget {
  static const String pageName = 'Query';
  static const String pageRoute = '/Query';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: const Center(
        child: Text("Query Page"),
      ),
      bottomNavigationBar: BottomNaviBar(),
    );
  }
}
