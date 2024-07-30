import 'package:chat_app/model/message.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  MessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return provider.user?.id == message.senderId
        ? SentMessage(message: message)
        : RecieveMessage(message: message);
  }
}

class SentMessage extends StatelessWidget {
  Message message;

  SentMessage({super.key, required this.message});
  String formatTime(int time) {
    int hour = time ~/ 100;
    int minute = time % 100;
    DateTime dateTime = DateTime(0, 1, 1, hour, minute);
    return DateFormat.Hm().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.06,
              vertical: MediaQuery.of(context).size.height * 0.02),
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12))),
          child: Text(
            message.content,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Text(
          formatTime(message.dateTime),
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}

class RecieveMessage extends StatelessWidget {
  Message message;
  RecieveMessage({super.key, required this.message});
  String formatTime(int time) {
    int hour = time ~/ 100;
    int minute = time % 100;
    DateTime dateTime = DateTime(0, 1, 1, hour, minute);
    return DateFormat.Hm().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formatTime(message.dateTime),
          style: const TextStyle(color: Colors.black),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.06,
              vertical: MediaQuery.of(context).size.height * 0.02),
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 172, 172, 172),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12))),
          child: Text(
            message.content,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
