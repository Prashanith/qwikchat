import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Message {
  Message(this.doc, this.documentId);

  final Object? doc;
  final String documentId;

  static List<Message> messagesFromList(List<QueryDocumentSnapshot> snapshots) {
    List<Message> messages = [];
    for (var element in snapshots) {
      messages.add(Message(element, element.id));
    }
    return messages;
  }

  String get docId => documentId;
  Map<String, dynamic> get json =>
      doc != null ? doc as Map<String, dynamic> : {};

  String get senderId => json['sender'] ?? '';
  String get id => json['id'] ?? '';
  DateTime? get readAt =>
      json['readAt'] != null ? (json['readAt'] as Timestamp).toDate() : null;
  DateTime get sentAt => (json['sentAt'] as Timestamp).toDate();
  String get message => json['message'] ?? '';

  static Map<String, dynamic> toJson(String sender, message) => {
        'id': const Uuid().v1(),
        'sentAt': DateTime.now().toUtc(),
        'readAt': null,
        'message': message,
        'sender': sender
      };
}
