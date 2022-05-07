import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snmp_browser/model/QueryResultModel.dart';
import 'package:snmp_browser/store/AppState.dart';
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

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);

    var body = StoreConnector<AppState, List<QueryResultModel>>(
        converter: (store) => store.state.histories,
        builder: (context, history) => Scaffold(
              appBar: TopBar(),
              body: _renderList(history),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.plus_one),
              ),
              bottomNavigationBar: BottomNaviBar(),
            ));

    return body;
  }
}
