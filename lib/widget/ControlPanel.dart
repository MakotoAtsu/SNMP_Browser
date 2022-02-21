import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ControlPanel extends StatelessWidget {
  List<String> _snmpOperations = ["Get", "Get-Next", "Walk"];

  List<DropdownMenuItem<String>> _operationList() {
    var result = _snmpOperations
        .map((value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ))
        .toList();

    return result;
  }

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
          const TextField(
            decoration: InputDecoration(labelText: "OID"),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30, bottom: 10),
            child: DropdownButton(
              items: _operationList(),
              onChanged: (x) => log("Change Method"),
            ),
          ),
          ElevatedButton(onPressed: () => log("aaaa"), child: const Text("Go!"))
        ],
      ),
    );

    return container;
  }
}
