import 'package:chat_app/data/database.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/view/chat/chat_navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatViewModel extends ChangeNotifier {
  late ChatNavigator chatNavigator;
  late MyUser currentUser;
  late Room room;
  late Stream<QuerySnapshot<Message>> streamMessage;
  void sendMessage(String content) async {
    Message message = Message(
        roomId: room.roomId,
        content: content,
        senderId: currentUser.id,
        senderName: currentUser.userName,
        dateTime: DateTime.now().millisecondsSinceEpoch);

    try {
      await Database.insertMessage(message);
      chatNavigator.clearMessage();
    } catch (e) {
      // chatNavigator.showMessage(e.toString());
    }
  }

  void listenForUpdateMessage() {
    streamMessage = Database.getMessagesFromFirestore(room.roomId);
  }
}
