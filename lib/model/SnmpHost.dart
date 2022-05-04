import 'dart:io';

enum SnmpVersion { v1, v2c, v3 }

class SnmpHost {
  InternetAddress? ip;
  int port = 161;
  SnmpVersion version = SnmpVersion.v2c;
  String readCommunityString = 'public';
  String writeCommunityString = '';
  String note = '';

  SnmpHost();

  SnmpHost clone() => SnmpHost.fromJson(toJson());

  Map<String, dynamic> toJson() => {
        'ip': ip,
        'port': port,
        'version': version,
        'readCommunityString': readCommunityString,
        'writeCommunityString': writeCommunityString,
      };

  SnmpHost.fromJson(Map<String, dynamic> json)
      : ip = json['ip'],
        port = json['port'],
        version = json['version'],
        readCommunityString = json['readCommunityString'],
        writeCommunityString = json['writeCommunityString'];
}
