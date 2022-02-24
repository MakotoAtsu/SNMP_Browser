import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/widget/GoButton.dart';

class QueryPanel extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    var info = StoreConnector<AppState, QueryInfo>(
        converter: (store) => store.state.queryInfo,
        builder: (context, queryInfo) => Container(
            margin: const EdgeInsets.only(top: 30, bottom: 10),
            child: Column(
              children: [
                const TextField(
                  decoration: InputDecoration(labelText: "OID :"),
                ),
                DropdownButton(
                  items: _operationList(),
                  onChanged: (x) => {print("Change Method")},
                ),
                GoButton()
              ],
            )));

    return info;
  }
}
