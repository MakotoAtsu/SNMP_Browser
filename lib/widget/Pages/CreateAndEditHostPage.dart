import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snmp_browser/model/HostModel.dart';
import 'package:snmp_browser/model/SnmpModel.dart';
import 'package:snmp_browser/store/AppState.dart';
import 'package:snmp_browser/store/reducer/HostsReducer.dart';
import 'package:snmp_browser/widget/Compoments/InputField.dart';
import 'package:snmp_browser/widget/Compoments/WidgetTool.dart';

class CreateAndEditHostPage extends StatefulWidget {
  static const String pageName = 'Create And Edit';
  static const String pageRoute = '/CreateAndEditHost';

  @override
  State<StatefulWidget> createState() => _CreateAndEditHostPage();
}

class _CreateAndEditHostPage extends State<CreateAndEditHostPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _hostId = -1;
  final TextEditingController _hostNameController = TextEditingController();
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _communityStringController =
      TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  SnmpVersion _snmpVersion = SnmpVersion.v2c;

  List<DropdownMenuItem<SnmpVersion>> get _snmpVersionItem => SnmpVersion.values
      .map((e) => DropdownMenuItem(child: Text(e.name), value: e))
      .toList();

  Widget _getInputForm() {
    var hostNameField = InputField(
      _hostNameController,
      'Host Name',
      true,
      hintText: 'Host Name',
    );

    var ipField = InputField(_ipController, 'IP Address', true,
        hintText: '192.168.1.X', validator: (String? value) {
      if (InternetAddress.tryParse(value!) == null) {
        return 'IP Address format error';
      } else {
        return null;
      }
    });

    var portField = InputField(_portController, 'Port', false,
        hintText: '161', formatter: [FilteringTextInputFormatter.digitsOnly]);

    var snmpVersionDropdown = DropdownButton(
        value: _snmpVersion,
        items: _snmpVersionItem,
        onChanged: (SnmpVersion? value) => setState(() {
              _snmpVersion = value!;
            }));

    var versionField = WidgetTool.createPadding([
      const Text('Snmp Version :'),
      snmpVersionDropdown,
    ]);

    var communityStringField = InputField(
      _communityStringController,
      'Community String',
      false,
      hintText: 'public',
    );

    var noteField = InputField(_noteController, 'Note', false);

    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          hostNameField,
          ipField,
          portField,
          versionField,
          communityStringField,
          noteField,
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dynamic params = ModalRoute.of(context)!.settings.arguments;

    if (params != null && params['hostId'] != null) {
      var hosts = StoreProvider.of<AppState>(context).state.hosts;

      var listIdx = hosts.indexWhere((x) => x.id == params['hostId']);

      var editorHost = hosts[listIdx];
      _hostId = editorHost.id!;

      _hostNameController.text = editorHost.name!;
      _ipController.text = editorHost.ip!.address;
      _portController.text = editorHost.port.toString();
      _snmpVersion = editorHost.version;
      _communityStringController.text = editorHost.readCommunityString;
      _noteController.text = editorHost.note;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text((_hostId >= 0 ? 'Edit ' : 'Create ') + 'Host'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;

              var h = HostModel();
              h.id = _hostId;
              h.ip = InternetAddress.tryParse(_ipController.text);
              h.name = _hostNameController.text;
              h.port = _portController.text.isNotEmpty
                  ? int.parse(_portController.text)
                  : 161;
              h.version = _snmpVersion;
              h.readCommunityString = _communityStringController.text.isNotEmpty
                  ? _communityStringController.text
                  : 'public';

              h.note = _noteController.text;

              if (_hostId >= 0) {
                StoreProvider.of<AppState>(context).dispatch(UpdateHostAction(h,
                    onComplete: () => Navigator.of(context).pop()));
              } else {
                StoreProvider.of<AppState>(context).dispatch(CreateHostAction(h,
                    onComplete: () => Navigator.of(context).pop()));
              }
            },
          ),
        ],
      ),
      body: Center(
        child: _getInputForm(),
      ),
    );
  }
}
