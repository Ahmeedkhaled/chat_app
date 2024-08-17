import 'package:chat_app/data/database.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/view/screen/add_room/widgets/room_widget.dart';
import 'package:chat_app/view/screen/home/home_navigator.dart';
import 'package:chat_app/view/screen/home/home_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemHome extends StatefulWidget {
  const ItemHome({super.key});

  @override
  State<ItemHome> createState() => _ItemHomeState();
}

class _ItemHomeState extends State<ItemHome> implements HomeNavigator {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    homeViewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => homeViewModel,
      child: StreamBuilder<QuerySnapshot<Room>>(
        stream: Database.getRooms(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          } else if (asyncSnapshot.hasError) {
            return Text(asyncSnapshot.error.toString());
          } else {
            var roomList =
                asyncSnapshot.data?.docs.map((doc) => doc.data()).toList();

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                Room room = roomList![index];
                return GestureDetector(
                  onLongPress: () {
                    _showDeleteDialog(context, room.roomId);
                  },
                  child: RoomWidget(room: room),
                );
              },
              itemCount: roomList!.length,
            );
          }
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String roomId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Room'),
          content: const Text('Are you sure you want to delete this room?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                homeViewModel.deleteRoom(roomId);
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
