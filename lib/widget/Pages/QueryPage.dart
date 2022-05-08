import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snmp_browser/model/QueryResultModel.dart';
import 'package:snmp_browser/model/SnmpModel.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/store/reducer/HistoryReducer.dart';
import 'package:snmp_browser/widget/Compoments/BottomNaviBar.dart';
import 'package:snmp_browser/widget/Compoments/InputField.dart';
import 'package:snmp_browser/widget/Compoments/LoadingIcon.dart';
import 'package:snmp_browser/widget/Compoments/TopBar.dart';
import 'package:snmp_browser/widget/Compoments/WidgetTool.dart';

class QueryPage extends StatefulWidget {
  static const String pageName = 'Query';
  static const String pageRoute = '/Query';

  @override
  State<StatefulWidget> createState() => _QueryPage();
}

class _QueryPage extends State<QueryPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _oidController = TextEditingController()
    ..text = '1.3';
  SnmpMethod _snmpMethod = SnmpMethod.getNext;

  List<DropdownMenuItem<SnmpMethod>> get _snmpVersionItem => SnmpMethod.values
      .map((e) => DropdownMenuItem(child: Text(e.name), value: e))
      .toList();

  void _catchQueryError(e) {
    String? errMsg;
    try {
      errMsg = e.message;
    } catch (e) {
      // Do nothing
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text((errMsg ?? 'Oops! Somthing wrong') + '...'),
      duration: const Duration(seconds: 5),
    ));
  }

  Widget _createHostPanel(BuildContext context) {
    var currentHost =
        StoreProvider.of<AppState>(context).state.queryPageStatus.queryTarget;

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
    var store = StoreProvider.of<AppState>(context);

    var _isLoading = store.state.queryPageStatus.isBusy;

    var button = WidgetTool.createPadding([
      FloatingActionButton.extended(
        backgroundColor: _isLoading ? Colors.grey : null,
        icon: const Icon(Icons.search),
        label: const Text('Query'),
        onPressed: _isLoading
            ? null
            : () {
                if (!_formKey.currentState!.validate()) return;

                store.dispatch(QuerySnmpAction(
                  _oidController.text,
                  _snmpMethod,
                  onExecuting: () => setState(() {
                    _isLoading = true;
                  }),
                  onComplete: (result) => setState(() {
                    if (result is QueryResultModel) {
                      _oidController.text = result.oid;
                    }
                    _isLoading = false;
                  }),
                  onError: (e) => _catchQueryError(e),
                ));
              },
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

    var form = Form(key: _formKey, child: card);
    return form;
  }

  Widget _createResultPanel(QueryResultModel result) => ListTile(
        title: Text(result.oid),
        subtitle: Text(result.value),
      );

  @override
  Widget build(BuildContext context) {
    var connector = StoreBuilder<AppState>(
      builder: (context, store) {
        return Scaffold(
          appBar: TopBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createHostPanel(context),
              _createSearchPanel(),
              const Spacer(),
              store.state.queryPageStatus.isBusy
                  ? LoadingIcon()
                  : (store.state.histories.isEmpty
                      ? const Spacer()
                      : _createResultPanel(store.state.histories.last)),
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
