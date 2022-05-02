import 'package:flutter/material.dart';
import 'package:snmp_browser/widget/Pages/QueryPage.dart';

class ControlPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var container = Container(
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextField(
            decoration: InputDecoration(labelText: "IP Address :"),
          ),
          const TextField(
            decoration: InputDecoration(labelText: "Port"),
          ),
          const TextField(
            decoration: InputDecoration(labelText: "Version"),
          ),
          const TextField(
            decoration: InputDecoration(labelText: "Read Community"),
          ),
          const TextField(
            decoration: InputDecoration(labelText: "Write Community"),
          ),
          Expanded(child: QueryPanel()),
        ],
      ),
    );

    return container;
  }
}