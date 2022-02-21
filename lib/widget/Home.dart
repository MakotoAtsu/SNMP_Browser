import 'dart:io';
import 'package:flutter/material.dart';
import 'package:snmp_browser/widget/ControlPanel.dart';
import 'QueryHistory.dart';

class Home extends StatelessWidget {
  AppBar? topAppBar() {
    // If it' run on desktop env, do not show AppBar
    if (Platform.isWindows || Platform.isMacOS) return null;

    return AppBar(
      title: const Text("Snmp Browser"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(),
      backgroundColor: Color.fromARGB(255, 180, 219, 255),
      // body: QueryHistory(),
      body: Row(
        children: [
          Expanded(flex: 2, child: ControlPanel()),
          Container(
            color: Colors.black,
            width: 1,
          ),
          Expanded(flex: 8, child: QueryHistory())
        ],
      ),
    );
  }
}
