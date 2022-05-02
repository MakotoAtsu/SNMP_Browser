import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snmp_browser/widget/Compoments/BottomNavi.dart';
import 'package:snmp_browser/widget/Compoments/TopBar.dart';

class HostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Donothing
        },
      ),
      body: const Center(child: Text("Hosts Page")),
      bottomNavigationBar: BottomNaviBar(),
    );
  }
}
