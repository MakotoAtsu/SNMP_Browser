class QueryResultModel {
  final String oid;
  final int tag;
  final String value;
  String get type => "TypeName";

  QueryResultModel(this.oid, this.tag, this.value);
}
