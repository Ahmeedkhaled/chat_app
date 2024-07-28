import 'package:chat_app/model/room.dart';
import 'package:chat_app/view/chat/chat_navigator.dart';
import 'package:chat_app/view/chat/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ChatForJoinGroup extends StatefulWidget {
  const ChatForJoinGroup({super.key});

  @override
  State<ChatForJoinGroup> createState() => _ChatForJoinGroupState();
}

class _ChatForJoinGroupState extends State<ChatForJoinGroup>
    implements ChatNavigator {
  ChatViewModel chatViewModel = ChatViewModel();

  @override
  void initState() {
    super.initState();
    chatViewModel.chatNavigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Room;
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
              child: Container(
                  // هنا يمكنك إضافة محتوى الشات أو الرسائل
                  ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      focusColor: Colors.blue,
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
                    width: 50, // Adjust the size as needed
                    height: 50, // Adjust the size as needed
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.blue),
                      onPressed: () {},
                      child: const Icon(
                        Icons.send_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8), // لإضافة مسافة صغيرة تحت العناصر
          ],
        ),
      ),
    );
  }
}
