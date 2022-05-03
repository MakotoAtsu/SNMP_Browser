import 'package:flutter/material.dart';
import 'package:snmp_browser/database/AppDB.dart';
import 'package:snmp_browser/database/entity/Host.dart';
import 'package:snmp_browser/widget/Compoments/BottomNavi.dart';
import 'package:snmp_browser/widget/Compoments/TopBar.dart';

class HostsPage extends StatelessWidget {
  late final AppDB db;

  Future doSomthing() async {
    var currentCount = (await db.getAllHosts()).length;

    var host = Host(
        id: 0,
        hostName: 'host1',
        ip: '192.168.1.1',
        version: 2,
        readCommunityString: 'public',
        writeCommunityString: 'public',
        note: 'note');

    await db.createHost(host);
  }

  @override
  Widget build(BuildContext context) {
    db = AppDB();

    return Scaffold(
      appBar: TopBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_box_outlined),
        onPressed: () async {
          doSomthing();
        },
      ),
      body: const Center(child: Text("HostPage")),
      bottomNavigationBar: BottomNaviBar(),
    );
  }
}
