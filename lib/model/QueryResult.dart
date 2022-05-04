class QueryResult {
  final String oid;
  final int tag;
  final String value;
  String get type => "TypeName";

  QueryResult(this.oid, this.tag, this.value);
}
