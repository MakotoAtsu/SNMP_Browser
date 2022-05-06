import 'dart:io';
import 'SnmpModel.dart';

class HostModel {
  int? id;
  String? name;
  InternetAddress? ip;
  int port = 161;
  SnmpVersion version = SnmpVersion.v2c;
  String readCommunityString = 'public';
  String writeCommunityString = '';
  String note = '';

  bool get isValid => ip != null && id != null;

  HostModel();

  HostModel clone() => HostModel.fromJson(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'ip': ip,
        'port': port,
        'version': version,
        'readCommunityString': readCommunityString,
        'writeCommunityString': writeCommunityString,
      };

  HostModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        ip = json['ip'],
        port = json['port'],
        version = json['version'],
        readCommunityString = json['readCommunityString'],
        writeCommunityString = json['writeCommunityString'];
}
