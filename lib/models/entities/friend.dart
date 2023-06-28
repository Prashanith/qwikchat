import 'package:cloud_firestore/cloud_firestore.dart';

class Friend {
  Friend(
    this.doc,
    this.documentId,
  );

  final Object? doc;
  final String documentId;

  String get docId => documentId;
  Map<String, dynamic> get json =>
      doc == null ? {} : doc as Map<String, dynamic>;

  String get id => (json['id']); // friend id
  String get chatId => json['chatId']; // chat id
  DateTime get friendsSince => (json['sentAt'] as Timestamp).toDate();
}
