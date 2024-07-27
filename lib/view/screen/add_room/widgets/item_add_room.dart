import 'dart:async';

import 'package:chat_app/constant/images.dart';
import 'package:chat_app/constant/routes_app.dart';
import 'package:chat_app/model/category.dart';
import 'package:chat_app/view/screen/add_room/add_room_navigator.dart';
import 'package:chat_app/view/screen/add_room/add_room_view_model.dart';
import 'package:chat_app/view/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/constant/utils.dart' as utils;

class ItemAddRoom extends StatefulWidget {
  const ItemAddRoom({super.key});

  @override
  State<ItemAddRoom> createState() => _ItemAddRoomState();
}

class _ItemAddRoomState extends State<ItemAddRoom> implements AddRoomNavigator {
  AddRoomViewModel addRoomViewModel = AddRoomViewModel();
  String roomTitle = '';
  String roomDescription = '';
  var formKey = GlobalKey<FormState>();
  var categoryList = Category.getCategory();
  Category? selectedItem;
  @override
  void initState() {
    super.initState();
    addRoomViewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => addRoomViewModel,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 32),
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(1, 2),
              ),
            ],
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  const Center(
                    child: Text(
                      "Create New Room",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Image.asset(groupImage),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  CustomTextForm(
                      onChanged: (value) {
                        roomTitle = value;
                      },
                      hintText: "Enter Room Title",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "please enter your title";
                        }
                        return null;
                      },
                      labelText: "Title"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  DropdownButton<Category>(
                      itemHeight: MediaQuery.of(context).size.height * 0.08,
                      borderRadius: BorderRadius.circular(15),
                      isExpanded: true,
                      value: selectedItem,
                      hint: const Text(
                        "Select Category",
                        style: TextStyle(fontSize: 18),
                      ),
                      iconSize: 30,
                      items: categoryList.map((category) {
                        return DropdownMenuItem<Category>(
                          value: category,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                category.title,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              Image.asset(category.image)
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (Category? newValue) {
                        if (newValue == null) return;
                        setState(() {
                          selectedItem = newValue;
                        });
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  CustomTextForm(
                    onChanged: (value) {
                      roomDescription = value;
                    },
                    hintText: "Enter Room Description",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "please enter your description";
                      }
                      return null;
                    },
                    labelText: "Description",
                    maxLines: 4,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
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
                          "Add Room",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 18),
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void validateForm() {
    if (formKey.currentState!.validate() == true) {
      addRoomViewModel.addRoom(
          roomTitle, roomDescription, selectedItem?.id ?? "");
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
  void showMessage(String msg) {
    utils.showMessage(context, msg, "ok", (context) {
      Navigator.of(context).pushReplacementNamed(RoutesApp.homeScreen);
    });
  }
}
