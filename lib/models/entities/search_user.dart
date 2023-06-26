import 'package:cloud_firestore/cloud_firestore.dart';

class SearchUser {
  SearchUser(this.doc);

  final QueryDocumentSnapshot doc;

  String get docId => doc.id;
  Map<String, dynamic> get json =>
      doc.data() != null ? doc.data() as Map<String, dynamic> : {};

  String get displayName => json['displayName'];
  String get id => json['id'];
  String get photoUrl => json['photoUrl'];
}
