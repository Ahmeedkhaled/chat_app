import 'package:chat_app/constant/firebase_error.dart';
import 'package:chat_app/view/screen/auth/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  late RegisterNavigator navigator;
  void registerFirebaseAuth(String email, String password) async {
    try {
      navigator.showLoading();
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      navigator.hideLoading();
      navigator.showMessage("Register Successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseError.weakPassword) {
        navigator.hideLoading();
        navigator.showMessage("The password provided is too weak.");
      } else if (e.code == FirebaseError.emailAlreadyInUse) {
        navigator.hideLoading();
        navigator.showMessage("The account already exists for that email.");
      }
    } catch (e) {
      navigator.hideLoading();
      navigator.showMessage(e.toString());
    }
  }
}
