import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  static CollectionReference publicUsersCollection =
      FirebaseFirestore.instance.collection('publicUsers');
  static CollectionReference chatsCollection =
      FirebaseFirestore.instance.collection('chats');
  static CollectionReference friendsCollection =
      FirebaseFirestore.instance.collection('friends');
  static CollectionReference requestsCollection =
      FirebaseFirestore.instance.collection('requests');

  static CollectionReference messagesCollection(String docId) =>
      FirebaseFirestore.instance
          .collection('chats')
          .doc(docId)
          .collection('messages');
}
