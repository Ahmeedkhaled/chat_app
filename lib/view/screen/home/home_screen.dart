import 'package:chat_app/constant/images.dart';
import 'package:chat_app/view/screen/home/widgets/custom_home_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        const CustomHomePage(title: "       Home Screen"),
      ],
    );
  }
}
