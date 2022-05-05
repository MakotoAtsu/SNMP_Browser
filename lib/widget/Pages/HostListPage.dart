import 'package:flutter/material.dart';
import 'package:snmp_browser/model/HostModel.dart';
import 'package:snmp_browser/service/HostService.dart';
import 'package:snmp_browser/widget/Compoments/BottomNaviBar.dart';
import 'package:snmp_browser/widget/Compoments/LoadingIcon.dart';
import 'package:snmp_browser/widget/Pages/CreateAndEditHostPage.dart';

class HostListPage extends StatelessWidget {
  static const String pageName = 'Hosts';
  static const String pageRoute = '/Hosts';

  Widget _createCard(HostModel model) {
    var hostIP = Text(model.ip!.address);
    var hostPort = Text(model.port.toString());
    var hostName = Text(model.name!);
    var version = Text('SNMP version : ' + model.version.toString());

    var listTitle = ListTile(
      onTap: () {
        var aa = 'ccc';
      },
      leading: const Icon(Icons.circle),
      title: hostName,
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          hostIP,
          hostPort,
          version,
        ],
      ),
    );

    var card = Card(child: listTitle);

    return card;
  }

  Widget _getCard() {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text('The Enchanted Nightingale'),
            subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     TextButton(
          //       child: const Text('BUY TICKETS'),
          //       onPressed: () {/* ... */},
          //     ),
          //     const SizedBox(width: 8),
          //     TextButton(
          //       child: const Text('LISTEN'),
          //       onPressed: () {/* ... */},
          //     ),
          //     const SizedBox(width: 8),
          //   ],
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var builder = FutureBuilder<List<HostModel>>(
      future: HostService.getAllHostFromDB(),
      builder: (context, result) {
        if (result.hasData) {
          var hostList = ListView(
              children: result.data!.map((h) => _createCard(h)).toList());
          return hostList;
        } else {
          return LoadingIcon();
        }
      },
    );

    var body = Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Hosts')),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Create',
            onPressed: () {
              Navigator.of(context).pushNamed(CreateAndEditHostPage.pageRoute);
            },
          )
        ],
      ),
      body: builder,
      bottomNavigationBar: BottomNaviBar(),
    );

    return body;
  }
}
