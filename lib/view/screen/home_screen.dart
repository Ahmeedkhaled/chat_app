import 'package:chat_app/constant/images.dart';
import 'package:chat_app/view/screen/auth/register/widgets/custom_register.dart';
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
        CustomRegister(title: "Home Screen"),
      ],
    );
  }
}
