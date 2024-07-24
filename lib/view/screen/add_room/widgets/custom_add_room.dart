import 'package:chat_app/constant/routes_app.dart';
import 'package:chat_app/view/screen/add_room/widgets/item_add_room.dart';
import 'package:flutter/material.dart';

class CustomAddRoom extends StatelessWidget {
  const CustomAddRoom({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(RoutesApp.homeScreen);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.09),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: SingleChildScrollView(
                child: ItemAddRoom(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
