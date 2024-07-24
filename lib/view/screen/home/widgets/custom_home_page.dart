import 'package:chat_app/constant/routes_app.dart';
import 'package:chat_app/view/screen/auth/register/widgets/custom_form_feild.dart';
import 'package:chat_app/view/screen/home/widgets/floating_action_button.dart';
import 'package:chat_app/view/screen/home/widgets/item_home.dart';
import 'package:flutter/material.dart';

class CustomHomePage extends StatelessWidget {
  const CustomHomePage({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const CustomFloatingActionButton(),
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.only(right: 15),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(RoutesApp.loginScreen);
                  },
                  icon: const Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: ItemHome(),
            ),
          ),
        ],
      ),
    );
  }
}
