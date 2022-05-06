import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:snmp_browser/model/HostModel.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/store/reducer/HostsReducer.dart';
import 'package:snmp_browser/store/reducer/TargetReducer.dart';
import 'package:snmp_browser/widget/Compoments/BottomNaviBar.dart';
import 'package:snmp_browser/widget/Compoments/LoadingIcon.dart';
import 'package:snmp_browser/widget/Pages/CreateAndEditHostPage.dart';

class HostListPage extends StatefulWidget {
  static const String pageName = 'Hosts';
  static const String pageRoute = '/Hosts';

  @override
  State<StatefulWidget> createState() => _HostListPage();
}

class _HostListPage extends State<HostListPage> {
  late Store<AppState> _store;
  late NavigatorState _navigator;
  bool isLoading = false;

  Widget _createCard(HostModel model) {
    var hostIP = Text(model.ip!.address);
    var hostPort = Text(model.port.toString());
    var hostName = Text(model.name!);
    var version = Text('SNMP version : ' + model.version.toString());

    var listTitle = ListTile(
        onTap: () {
          _store.dispatch(UpdateQueryTargetAction(model));
        },
        leading: const Icon(Icons.circle),
        title: hostName,
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            hostIP,
            // hostPort,
            // version,
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                _navigator.pushNamed(CreateAndEditHostPage.pageRoute,
                    arguments: {'hostId': model.id});
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _store.dispatch(DeleteHostAction(model.id!)),
            ),
          ],
        ));

    var card = Card(child: listTitle);

    return card;
  }

  @override
  Widget build(BuildContext context) {
    _navigator = Navigator.of(context);
    _store = StoreProvider.of<AppState>(context);

    var connector = StoreConnector<AppState, List<HostModel>>(
      converter: (store) => store.state.hosts,
      onInit: (store) {
        isLoading = true;
        store.dispatch(FetchHostsAction(
          onComplete: () {
            isLoading = false;
          },
        ));
      },
      builder: (context, hosts) {
        Widget body;
        if (isLoading) {
          body = LoadingIcon();
        } else {
          body = ListView(children: hosts.map((h) => _createCard(h)).toList());
        }

        var sca = Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Hosts')),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                tooltip: 'Create',
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(CreateAndEditHostPage.pageRoute);
                },
              )
            ],
          ),
          body: body,
          bottomNavigationBar: BottomNaviBar(),
        );

        return sca;
      },
    );

    return connector;
  }
}
