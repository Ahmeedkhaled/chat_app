import 'package:chat_app/constant/routes_app.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/view/chat/widget/chat_for_join_group.dart';
import 'package:flutter/material.dart';

class CustomChat extends StatelessWidget {
  const CustomChat({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Room;

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
                        args.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: ChatForJoinGroup(),
            ),
          ],
        ),
      ),
    );
  }
}
