import 'package:chat_app/view/screen/auth/login/widgets/custom_form_feild_login.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomLogin extends StatelessWidget {
  CustomLogin({super.key, required this.title});
  String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.1),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )),
          const Expanded(
            child: SingleChildScrollView(
              child: CustomFormFieldLogin(),
            ),
          ),
        ],
      ),
    );
  }
}
