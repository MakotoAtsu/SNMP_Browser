import 'dart:io';

import 'package:dart_snmp/dart_snmp.dart';
import 'package:flutter/material.dart';

class QueryHistory extends StatefulWidget {
  @override
  State<QueryHistory> createState() => _QueryStateHistory();
}

class _QueryStateHistory extends State<QueryHistory> {
  List<Message> _History = [];

  @override
  void initState() {
    super.initState();

    Snmp.createSession(InternetAddress("192.168.13.254")).then((session) =>
        session
            .getNext(Oid.fromString("1.3.6.1.2"))
            .then((response) => updateData(response)));
  }

  void updateData(Message input) {
    setState(() {
      _History.add(input);
      _History.add(input);
      _History.add(input);
      _History.add(input);
      _History.add(input);
      _History.add(input);
      _History.add(input);
      _History.add(input);
    });
  }

  ListView _renderList() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: _History.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
          title:
              Text(_History[index].pdu.varbinds[0].oid.identifier ?? "Unknown"),
          subtitle: Text(_History[index].pdu.varbinds[0].value.toString())),
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Colors.red,
        thickness: 8,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _renderList();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     color: const Color(0xFF99ffff),
  //     child: SizedBox(
  //         height: 1000,
  //         width: 2000,
  //         child: ListView(
  //           children: const [
  //             ListTile(
  //               title: Text("OID"),
  //               subtitle: Text("Result"),
  //             )
  //           ],
  //         )),
  //   );
  // }
}
