
class SearchUser {
  SearchUser(this.doc, this.docId);

  final Object? doc;
  final String docId;

  Map<String, dynamic> get json =>
      doc != null ? doc as Map<String, dynamic> : {};

  String get displayName => json['displayName'];
  String get id => json['id'];
  String get photoUrl => json['photoUrl'];
}
