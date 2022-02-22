import 'package:dart_snmp/dart_snmp.dart';

// Store
class AppState {
  List<Message> queryHistory = [];

  AppState({List<Message> history = const []}) {
    queryHistory = history;
  }

  static AppState from(AppState origin) {
    var history = origin.queryHistory;
    var newState = AppState(history: history);
    return newState;
  }
}

// Action
class AddQueryHistort {
  Message message;
  AddQueryHistort(this.message);
}

class RemoveQueryHistory {
  int historyIndex;
  RemoveQueryHistory(this.historyIndex);
}

// Reducer
AppState appStateReducer(AppState oldState, dynamic param) {
  var newState = AppState.from(oldState);

  switch (param.runtimeType) {
    case AddQueryHistort:
      var newHistory = List<Message>.from(oldState.queryHistory);
      newHistory.add((param as AddQueryHistort).message);
      newState.queryHistory = newHistory;
      break;
    case RemoveQueryHistory:
      var newHistory = List<Message>.from(oldState.queryHistory);
      newHistory.removeAt((param as RemoveQueryHistory).historyIndex);
      newState.queryHistory = newHistory;
      break;
    default:
      break;
  }

  return newState;
}
