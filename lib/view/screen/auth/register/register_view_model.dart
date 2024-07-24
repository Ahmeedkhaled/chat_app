import 'package:chat_app/constant/auth_navigator.dart';
import 'package:chat_app/constant/firebase_error.dart';
import 'package:chat_app/data/database.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  late AuthNavigator navigator;
  void registerFirebaseAuth(String email, String password, String firstName,
      String lastName, String userName) async {
    try {
      navigator.showLoading();
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var user = MyUser(
          id: result.user?.uid ?? '',
          firstName: firstName,
          lastName: lastName,
          userName: userName,
          email: email);

      var dataUser = await Database.registerUser(user);

      navigator.hideLoading();
      navigator.showMessage("Register Successfully");
      navigator.navigateToHome(user);
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
