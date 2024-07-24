import 'package:chat_app/constant/auth_navigator.dart';
import 'package:chat_app/constant/firebase_error.dart';
import 'package:chat_app/data/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  late AuthNavigator navigator;
  void loginFirebaseAuth(String email, String password) async {
    try {
      navigator.showLoading();
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var userObj = await Database.getUser(result.user?.uid ?? '');
      if (userObj == null) {
        navigator.hideLoading();
        navigator.showMessage("Register Failed please Try Again");
      } else {
        navigator.hideLoading();
        navigator.showMessage("Login Successfully");
        navigator.navigateToHome(userObj);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseError.usernotfound) {
        navigator.hideLoading();
        navigator.showMessage("No user found for that email.");
      } else if (e.code == FirebaseError.wrongpassword) {
        navigator.hideLoading();
        navigator.showMessage("Wrong password provided for that user.");
      }
    }
  }
}
