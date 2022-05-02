import 'dart:io';
import 'package:redux/redux.dart';

enum SnmpVersion { v1, v2c, v3 }

// Model
class QueryTarget {
  InternetAddress? ip;
  int port = 161;
  SnmpVersion version = SnmpVersion.v2c;
  String readCommunityString = 'public';
  String writeCommunityString = '';

  QueryTarget();

  QueryTarget clone() => QueryTarget.fromJson(toJson());

  Map<String, dynamic> toJson() => {
        'ip': ip,
        'port': port,
        'version': version,
        'readCommunityString': readCommunityString,
        'writeCommunityString': writeCommunityString,
      };

  QueryTarget.fromJson(Map<String, dynamic> json)
      : ip = json['ip'],
        port = json['port'],
        version = json['version'],
        readCommunityString = json['readCommunityString'],
        writeCommunityString = json['writeCommunityString'];
}

// Action
class UpdateQueryTargetAction {
  final QueryTarget target;
  UpdateQueryTargetAction(this.target);
}

// Reducer
QueryTarget UpdateTargetReducer(
        QueryTarget oldTarget, UpdateQueryTargetAction action) =>
    action.target;

Reducer<QueryTarget> QueryTargetReducer = combineReducers<QueryTarget>(
    [TypedReducer<QueryTarget, UpdateQueryTargetAction>(UpdateTargetReducer)]);
