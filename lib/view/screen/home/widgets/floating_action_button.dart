import 'package:chat_app/constant/routes_app.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed(RoutesApp.addRoom);
      },
      child: const Icon(Icons.add),
    );
  }
}
