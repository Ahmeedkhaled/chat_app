import 'package:chat_app/constant/routes_app.dart';
import 'package:chat_app/view/screen/auth/login/login_navigator.dart';
import 'package:chat_app/view/screen/auth/login/login_view_model.dart';
import 'package:chat_app/view/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/constant/utils.dart' as utils;

class CustomFormFieldLogin extends StatefulWidget {
  const CustomFormFieldLogin({super.key});

  @override
  State<CustomFormFieldLogin> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormFieldLogin>
    implements LoginNavigator {
  String email = '';

  String password = '';

  bool isObscure = true;
  var formKey = GlobalKey<FormState>();

  LoginViewModel loginViewModel = LoginViewModel();

  @override
  void initState() {
    super.initState();
    loginViewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => loginViewModel,
      child: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
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
                          "Login",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 18),
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RoutesApp.registerScreen);
                      },
                      child: const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ))
                ],
              ),
            )),
      ),
    );
  }

  void validateForm() async {
    if (formKey.currentState?.validate() == true) {
      loginViewModel.loginFirebaseAuth(email, password);
    }
  }

  @override
  void hideLoading() {
    utils.hideLoading(context);
  }

  @override
  void showLoading() {
    utils.showLoading(context);
  }

  @override
  void showMessage(String message) {
    utils.showMessage(context, message, "Ok", (context) {
      Navigator.of(context).pushReplacementNamed(RoutesApp.homeScreen);
    });
  }
}
