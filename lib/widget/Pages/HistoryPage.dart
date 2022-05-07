import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snmp_browser/model/QueryResultModel.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/widget/Compoments/BottomNaviBar.dart';
import 'package:snmp_browser/widget/Compoments/TopBar.dart';

class HistoryPage extends StatefulWidget {
  static const String pageName = 'Query History';
  static const String pageRoute = '/History';

  @override
  State<StatefulWidget> createState() => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage> {
  late final Store<AppState> store;

  final ScrollController _scrollController = ScrollController();

  ListView _renderList(List<QueryResultModel> history) {
    return ListView.separated(
      controller: _scrollController,
      shrinkWrap: true,
      itemCount: history.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
          title: Text(history[index].oid),
          subtitle: Text(history[index].value)),
      separatorBuilder: (BuildContext context, int index) => const Divider(
        thickness: 4,
      ),
    );
  }

  void _scrollDown() {
    // _scrollController.animateTo(
    //   _scrollController.position.maxScrollExtent,
    //   duration: const Duration(seconds: 0),
    //   curve: Curves.fastOutSlowIn,
    // );
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);
    SchedulerBinding.instance?.addPostFrameCallback((_) => _scrollDown());
    var body = StoreConnector<AppState, List<QueryResultModel>>(
        converter: (store) => store.state.histories,
        onWillChange: (_, __) => _scrollDown(),
        builder: (context, history) => Scaffold(
              appBar: TopBar(),
              body: _renderList(history),
              floatingActionButton: FloatingActionButton(
                onPressed: () => _scrollDown(),
                child: const Icon(Icons.plus_one),
              ),
              bottomNavigationBar: BottomNaviBar(),
            ));

    return body;
  }
}
