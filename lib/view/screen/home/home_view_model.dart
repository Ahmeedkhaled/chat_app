import 'package:chat_app/data/database.dart';
import 'package:chat_app/view/screen/home/home_navigator.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  late HomeNavigator navigator;

  void getRoomFromFirestore() {
    Database.getRooms();
  }

  void deleteRoom(String roomId) {
    Database.deleteRoom(roomId);
  }
}
