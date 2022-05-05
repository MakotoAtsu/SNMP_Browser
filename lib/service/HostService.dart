import 'dart:io';
import 'package:snmp_browser/database/AppDB.dart';
import 'package:snmp_browser/model/HostModel.dart';

class HostService {
  static Future<List<HostModel>> getAllHostFromDB() async {
    await Future.delayed(const Duration(seconds: 3));

    var allHosts = await AppDB().getAllHosts();

    var hostsModel = allHosts.map((db) {
      var h = HostModel();
      h.id = db.id;
      h.name = db.hostName;
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

  static Future updateHost(HostModel hostModel) async {
    var host = Host(
        id: hostModel.id!,
        hostName: hostModel.name!,
        ip: hostModel.ip!.address,
        port: hostModel.port,
        version: hostModel.version.index,
        readCommunityString: hostModel.readCommunityString,
        writeCommunityString: hostModel.writeCommunityString,
        note: hostModel.note);

    await AppDB().updateHost(host);
  }

  static Future deleteHostById(int hostId) => AppDB().deleteHostById(hostId);

  static Future deleteHost(HostModel model) => deleteHostById(model.id!);
}
