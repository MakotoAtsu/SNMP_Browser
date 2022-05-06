import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snmp_browser/model/QueryResultModel.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/widget/Compoments/BottomNaviBar.dart';
import 'package:snmp_browser/widget/Compoments/InputField.dart';
import 'package:snmp_browser/widget/Compoments/TopBar.dart';
import 'package:snmp_browser/widget/Compoments/WidgetTool.dart';

enum SnmpMethod {
  get,
  getNext,
  // getBulk,
}

class QueryPage extends StatefulWidget {
  static const String pageName = 'Query';
  static const String pageRoute = '/Query';

  @override
  State<StatefulWidget> createState() => _QueryPage();
}

class _QueryPage extends State<QueryPage> {
  final TextEditingController _oidController = TextEditingController();
  SnmpMethod _snmpMethod = SnmpMethod.getNext;

  List<DropdownMenuItem<SnmpMethod>> get _snmpVersionItem => SnmpMethod.values
      .map((e) => DropdownMenuItem(child: Text(e.name), value: e))
      .toList();

  Widget _createHostPanel(BuildContext context) {
    var currentHost = StoreProvider.of<AppState>(context).state.queryTarget;

    var hostPanel = ListTile(
      contentPadding: const EdgeInsets.fromLTRB(30, 16, 30, 0),
      title: Text(
        'Host : ${currentHost.name} ' +
            (currentHost.note.isNotEmpty ? '(${currentHost.note})' : ''),
        style: const TextStyle(fontSize: 20),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('IP : ${currentHost.ip?.address}'),
          Text('SNMP Version : ${currentHost.version.name}'),
          Text('Community string : ${currentHost.readCommunityString}'),
        ],
      ),
    );

    return hostPanel;
  }

  Widget _createSearchButton() {
    var button = WidgetTool.createPadding([
      FloatingActionButton.extended(
        icon: const Icon(Icons.search),
        label: const Text('Query'),
        onPressed: () {},
      )
    ]);

    return button;
  }

  Widget _createSearchPanel() {
    var oidField = InputField(_oidController, 'OID', true,
        hintText: 'eg: 1.3.6.1.2.1.1.1', validator: (String? v) {
      if (v!.split('.').any((x) => int.tryParse(x) == null)) {
        return 'OID format error';
      } else {
        return null;
      }
    });

    var snmpMethodDropdown = DropdownButton(
        value: _snmpMethod,
        items: _snmpVersionItem,
        onChanged: (SnmpMethod? value) => setState(() {
              _snmpMethod = value!;
            }));

    var card = Card(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            oidField,
            WidgetTool.createPadding([snmpMethodDropdown],
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 30)),
          ]),
    );

    return card;
  }

  Widget _createResultPanel(QueryResultModel result) => ListTile(
        title: Text(result.oid),
        subtitle: Text(result.value),
      );

  @override
  Widget build(BuildContext context) {
    var connector = StoreConnector<AppState, QueryResultModel?>(
      converter: (store) => store.state.histories.lastOrNull,
      builder: (context, result) {
        return Scaffold(
          appBar: TopBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _createHostPanel(context),
              _createSearchPanel(),
              (result == null ? const Spacer() : _createResultPanel(result)),
              const Spacer(),
              Center(child: _createSearchButton()),
            ],
          ),
          bottomNavigationBar: BottomNaviBar(),
        );
      },
    );

    return connector;
  }
}
