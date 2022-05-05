import 'package:flutter/material.dart';

class CreateAndEditHostPage extends StatelessWidget {
  static const String pageName = 'Create And Edit';
  static const String pageRoute = '/CreateAndEditHost';

  @override
  Widget build(BuildContext context) {
    dynamic params = ModalRoute.of(context)!.settings.arguments;

    bool isEditor = false;
    if (params != null && params['HostId'] != null) {
      isEditor = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text((isEditor ? 'Edit' : 'Create') + 'Host'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
