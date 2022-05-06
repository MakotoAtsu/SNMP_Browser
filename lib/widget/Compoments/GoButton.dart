import 'dart:io';
import 'package:dart_snmp/dart_snmp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:snmp_browser/store/AppState.dart';

class GoButton extends StatelessWidget {
  late final Store<AppState> store;

  void query() async {
    var session = await Snmp.createSession(InternetAddress("172.24.54.28"));
    var result = await session.getNext(Oid.fromString("1.3.6.1.2"));

    // var action = querySnmpAction(QueryResultModel(
    //   result.pdu.varbinds[0].oid.toString(),
    //   result.pdu.varbinds[0].tag,
    //   result.pdu.varbinds[0].value,
    // ));
    // store.dispatch(action);
  }

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);

    var button = ElevatedButton(
      onPressed: () => query(),
      child: const Text("Go!"),
    );

    return button;
  }
}
