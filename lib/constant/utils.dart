import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 10,
              ),
              Text("Loading..."),
            ],
          ),
        );
      });
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}

void showMessage(BuildContext context, String message, String posActionText,
    Function posAction,
    {String? negActionText, Function? negAction}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding:
              const EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 15),
          contentPadding: const EdgeInsets.only(
            top: 15,
            right: 15,
            left: 15,
          ),
          content: Text(
            message,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  posAction(context);
                },
                child: Text(
                  posActionText,
                  style: const TextStyle(fontSize: 16),
                )),
          ],
        );
      });
}
