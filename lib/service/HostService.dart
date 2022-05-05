import 'dart:io';
import 'package:snmp_browser/database/AppDB.dart';
import 'package:snmp_browser/model/HostModel.dart';

class HostService {
  static Future<List<HostModel>> getAllHostFromDB() async {
    await Future.delayed(const Duration(seconds: 3));

    var allHosts = await AppDB().getAllHosts();

    var hostsModel = allHosts.map((db) {
      var h = HostModel();
      h.ip = InternetAddress.tryParse(db.ip);
      h.port = db.port;
      h.version = SnmpVersion.values[db.version];
      h.readCommunityString = db.readCommunityString;
      h.writeCommunityString = db.writeCommunityString;
      h.note = db.note;
      return h;
    }).toList();

    return hostsModel;
  }

  static Future<Host?> getHostFromDB(int id) => AppDB().getHostById(id);
}
