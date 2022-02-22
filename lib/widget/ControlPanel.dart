import 'dart:developer';
import 'dart:io';

import 'package:dart_snmp/dart_snmp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:redux/redux.dart';
import 'package:snmp_browser/widget/GoButton.dart';

class ControlPanel extends StatelessWidget {
  late final Store<AppState> store;
  final List<String> _snmpOperations = ["Get", "Get-Next", "Walk"];

  List<DropdownMenuItem<String>> _operationList() {
    var result = _snmpOperations
        .map((value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ))
        .toList();

    return result;
  }

  void querySnmp() async {
    var session = await Snmp.createSession(InternetAddress("192.168.13.254"));
    var response = await session.getNext(Oid.fromString("1.3.6.1.2"));
    store.dispatch(AddQueryHistort(response));
  }

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);

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
              onChanged: (x) => {print("Change Method")},
            ),
          ),
          GoButton()
        ],
      ),
    );

    return container;
  }
}
