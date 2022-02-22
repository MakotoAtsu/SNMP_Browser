import 'dart:io';

import 'package:dart_snmp/dart_snmp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snmp_browser/store/AppState.dart';

class QueryHistory extends StatelessWidget {
  ListView _renderList(List<Message> history) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: history.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
          title:
              Text(history[index].pdu.varbinds[0].oid.identifier ?? "Unknown"),
          subtitle: Text(history[index].pdu.varbinds[0].value.toString())),
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Colors.red,
        thickness: 8,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var historyWidget = StoreConnector<AppState, List<Message>>(
        converter: (store) => store.state.queryHistory,
        builder: (context, history) => _renderList(history));
    return historyWidget;
  }
}
