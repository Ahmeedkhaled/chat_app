import 'package:chat_app/constant/images.dart';
import 'package:chat_app/view/screen/auth/login/widgets/custom_login.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
        CustomLogin(title: "Login Screen"),
      ],
    );
  }
}
