import 'package:get/get.dart';

import 'message.dart';

class ChatHead {
  ChatHead(
    this.doc,
    this.documentId,
  );

  final Object? doc;
  final String documentId;
  String get docId => documentId;
  Map<String, dynamic> get json =>
      doc != null ? {} : doc as Map<String, dynamic>;

  String _imageUrl = '';
  String _profileName = '';
  final List<Message> _messages = [];

  void setProfile(String url, String name) {
    _imageUrl = url;
    _profileName = name;
  }

  bool get exists => doc != null;
  String get displayName => _profileName ?? '';
  String get id => json['id'] ?? '';
  String get photoUrl => _imageUrl ?? '';

  List<Message> get getMessages => _messages;

  void addMessage(Message message) {
    if (_messages.any((e) => e.id == message.id)) {
      return;
    }
    _messages.add(message);
  }

  void addMessages(List<Message> messages) {
    for (int i = 0; i < messages.length; i++) {
      _messages.addIf(
          _messages
              .every((element) => element.documentId != messages[i].documentId),
          messages[i]);
    }
    _messages.sort((a, b) => b.sentAt.compareTo(a.sentAt));
  }
}
