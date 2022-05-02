import 'package:flutter/material.dart';
import 'package:snmp_browser/widget/Compoments/GoButton.dart';

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
    return Container(child: GoButton());
  }
}
