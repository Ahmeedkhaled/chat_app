import 'package:chat_app/constant/images.dart';
import 'package:chat_app/view/screen/add_room/widgets/custom_add_room.dart';
import 'package:flutter/material.dart';

class AddRoom extends StatefulWidget {
  const AddRoom({super.key});

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
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
        const CustomAddRoom(title: "Add Room"),
      ],
    );
  }
}
