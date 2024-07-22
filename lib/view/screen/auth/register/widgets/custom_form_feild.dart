import 'package:chat_app/constant/firebase_error.dart';
import 'package:chat_app/view/widgets/custom_text_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({super.key});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  String firstName = '';

  String lastName = '';
  String email = '';

  String password = '';

  String userName = '';

  bool isObscure = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
      child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                CustomTextForm(
                  onChanged: (text) {
                    firstName = text;
                  },
                  labelText: "First Name",
                  hintText: "Enter your First Name",
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please Enter Your First Name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                CustomTextForm(
                  onChanged: (text) {
                    lastName = text;
                  },
                  labelText: "Last Name",
                  hintText: "Enter your Last Name",
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please Enter Your Last Name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                CustomTextForm(
                  onChanged: (text) {
                    userName = text;
                  },
                  labelText: "User Name",
                  hintText: "Enter your User Name",
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please Enter Your User Name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                CustomTextForm(
                    onChanged: (text) {
                      email = text;
                    },
                    labelText: "Email",
                    hintText: "Enter your Email",
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "please enter your email";
                      }
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return "please enter valid email";
                      }
                      return null;
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                CustomTextForm(
                  onChanged: (text) {
                    password = text;
                  },
                  suffixIcon: IconButton(
                      onPressed: () {
                        isObscure = !isObscure;
                        setState(() {});
                      },
                      icon: isObscure
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                  keyBoardType: TextInputType.number,
                  isObscure: isObscure,
                  hintText: "enter Your Password",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "please enter your Password";
                    }
                    if (value.trim().length < 6 || value.trim().length > 30) {
                      return "password should be >6&<30";
                    }
                    return null;
                  },
                  labelText: 'Password',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () {
                        validateForm();
                      },
                      child: Text(
                        "Create Account",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 18),
                      )),
                )
              ],
            ),
          )),
    );
  }

  void validateForm() async {
    if (formKey.currentState?.validate() == true) {
      try {
        final result =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print("=======================================");
        print("idddddddddddd:${result.user?.uid}");
        print("=======================================");
      } on FirebaseAuthException catch (e) {
        if (e.code == FirebaseError.weakPassword) {
          Fluttertoast.showToast(
              msg: "The password provided is too weak.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (e.code == FirebaseError.emailAlreadyInUse) {
          Fluttertoast.showToast(
              msg: "The account already exists for that email.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
}
