import 'package:chat_app/data/database.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/view/screen/add_room/add_room_navigator.dart';
import 'package:flutter/material.dart';

class AddRoomViewModel extends ChangeNotifier {
  late AddRoomNavigator navigator;

  void addRoom(
      String roomTitle, String roomDescription, String categoryId) async {
    Room room = Room(
        roomId: "",
        title: roomTitle,
        description: roomDescription,
        categoryId: categoryId);

    try {
      navigator.showLoading();
      var createdRoom = await Database.addRoomToFirestoreroom(room);
      navigator.hideLoading();
      navigator.showMessage("Room Was Added Successfully");
    } catch (e) {
      navigator.hideLoading();
      navigator.showMessage(e.toString());
    }
  }
}
