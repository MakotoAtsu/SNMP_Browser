import 'dart:io';
import 'package:dart_snmp/dart_snmp.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snmp_browser/model/QueryResultModel.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/store/reducer/HistoryReducer.dart';
import 'package:snmp_browser/widget/Compoments/BottomNaviBar.dart';
import 'package:snmp_browser/widget/Compoments/TopBar.dart';

class HistoryPage extends StatelessWidget {
  static const String pageName = 'Query History';
  static const String pageRoute = '/History';

  late final Store<AppState> store;

  ListView _renderList(List<QueryResultModel> history) {
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

    var action = AppendQueryResultAction(QueryResultModel(
      result.pdu.varbinds[0].oid.toString(),
      result.pdu.varbinds[0].tag,
      result.pdu.varbinds[0].value,
    ));

    store.dispatch(action);
  }

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);

    var body = StoreConnector<AppState, List<QueryResultModel>>(
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
