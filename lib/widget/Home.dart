import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../store/AppState.dart';
import 'Compoments/ButtomNavi.dart';

class Home extends StatelessWidget {
  AppBar? topAppBar() {
    return AppBar(
      title: const Text("SNMP MIB Browser"),
    );
  }

  @override
  Widget build(BuildContext context) {
    var body = StoreConnector<AppState, int>(
        converter: (store) => store.state.pageIndex,
        builder: (context, pageIdx) => Scaffold(
            appBar: topAppBar(),
            backgroundColor: Color.fromARGB(255, 180, 219, 255),
            // body: QueryHistory(),
            body: Center(child: Text("Page : " + pageIdx.toString())),
            bottomNavigationBar: ButtomNavi()));

    return body;
  }
}
