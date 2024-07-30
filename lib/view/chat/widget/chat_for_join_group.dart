import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/view/chat/chat_navigator.dart';
import 'package:chat_app/view/chat/chat_view_model.dart';
import 'package:chat_app/view/chat/widget/message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/constant/utils.dart' as utils;

class ChatForJoinGroup extends StatefulWidget {
  const ChatForJoinGroup({super.key});

  @override
  State<ChatForJoinGroup> createState() => _ChatForJoinGroupState();
}

class _ChatForJoinGroupState extends State<ChatForJoinGroup>
    implements ChatNavigator {
  ChatViewModel chatViewModel = ChatViewModel();
  String messageText = '';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    chatViewModel.chatNavigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Room;
    var provider = Provider.of<UserProvider>(context);
    chatViewModel.room = args;
    chatViewModel.currentUser = provider.user!;
    chatViewModel.listenForUpdateMessage();
    return ChangeNotifierProvider(
      create: (context) => chatViewModel,
      child: Container(
        height: 200,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 32),
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(1, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot<Message>>(
                    stream: chatViewModel.streamMessage,
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        );
                      } else if (asyncSnapshot.hasError) {
                        return Text(
                          asyncSnapshot.error.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                        );
                      } else {
                        var messageList = asyncSnapshot.data?.docs
                                .map((doc) => doc.data())
                                .toList() ??
                            [];

                        return ListView.builder(
                            itemCount: messageList.length,
                            itemBuilder: (context, index) {
                              return MessageWidget(message: messageList[index]);
                            });
                      }
                    })),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextField(
                    controller: controller,
                    onChanged: (text) {
                      messageText = text;
                    },
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      focusColor: Colors.blue,
                      hoverColor: Colors.blue,
                      fillColor: Colors.blue,

                      hintStyle: const TextStyle(fontSize: 16),
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(25)),
                          borderSide: BorderSide()),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.005,
                          horizontal: 10), // Adjust vertical padding
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: 45,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor:
                              const Color.fromARGB(255, 118, 182, 227)),
                      onPressed: () {
                        chatViewModel.sendMessage(messageText);
                      },
                      child: const Icon(
                        Icons.send_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  void clearMessage() {
    print("Clear Message");
    controller.clear();
  }

  // @override
  // showMessage(String message) {
  //   utils.showMessage(context, message, posActionText, posAction)
  // }
}
