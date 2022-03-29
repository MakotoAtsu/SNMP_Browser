import 'dart:io';

import 'package:dart_snmp/dart_snmp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snmp_browser/utility/SnmpUtility.dart';

void main() {
  group("SnmpUtility", () {
    test("Test SnmpUtility.getNext", () async {
      var target = SnmpUtility(InternetAddress("192.168.13.254"));
      var result = await target.getNext(Oid.fromString("1.3.6.1.2.1.1"));
      var result2 = await target.getNext(Oid.fromString("1.3.6.1.2.1.1.1.0"));
      expect(result, isNotEmpty);
    });
  });
}
