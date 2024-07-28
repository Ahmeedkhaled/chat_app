import 'package:chat_app/constant/images.dart';
import 'package:chat_app/view/chat/widget/custom_chat.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Image.asset(
          width: double.infinity,
          fit: BoxFit.fill,
          backgroundImage,
        ),
        const CustomChat(),
      ],
    );
  }
}
