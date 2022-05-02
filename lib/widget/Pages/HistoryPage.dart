import 'dart:io';
import 'package:dart_snmp/dart_snmp.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/store/HistoryReducer.dart';
import 'package:snmp_browser/widget/Compoments/BottomNavi.dart';
import 'package:snmp_browser/widget/Compoments/TopBar.dart';

class HistoryPage extends StatelessWidget {
  late final Store<AppState> store;

  ListView _renderList(List<QueryResult> history) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: history.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
          title: Text(history[index].oid),
          subtitle: Text(history[index].value)),
      separatorBuilder: (BuildContext context, int index) => const Divider(
        // color: Colors.red,
        thickness: 4,
      ),
    );
  }

  void query() async {
    var session = await Snmp.createSession(InternetAddress("172.24.54.28"));
    var result = await session.getNext(Oid.fromString("1.3.6.1.2"));

    var action = AppendQueryResultAction(QueryResult(
      result.pdu.varbinds[0].oid.toString(),
      result.pdu.varbinds[0].tag,
      result.pdu.varbinds[0].value,
    ));

    store.dispatch(action);
  }

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);

    var body = StoreConnector<AppState, List<QueryResult>>(
        converter: (store) => store.state.histories,
        builder: (context, history) => Scaffold(
              appBar: TopBar(),
              body: _renderList(history),
              floatingActionButton: FloatingActionButton(
                onPressed: () => query(),
                child: const Icon(Icons.plus_one),
              ),
              bottomNavigationBar: BottomNaviBar(),
            ));

    return body;
  }
}
