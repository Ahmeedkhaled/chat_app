import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextForm extends StatelessWidget {
  // final String? fieldName;
  final String? hintText;
  final String? labelText;
  int? maxLines;

  final Widget? suffixIcon;
  final bool? isObscure;
  final TextInputType keyBoardType;
  // final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  CustomTextForm(
      {super.key,
      this.maxLines = 1,
      // required this.fieldName,
      // required this.controller,
      required this.onChanged,
      this.isObscure = false,
      this.keyBoardType = TextInputType.text,
      required this.hintText,
      required this.validator,
      this.suffixIcon,
      required this.labelText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Text(
          //   fieldName ?? "",
          //   style: const TextStyle(
          //     color: Colors.white,
          //     fontSize: 16,
          //   ),
          // ),
          // const SizedBox(
          //   height: 15,
          // ),
          TextFormField(
            maxLines: maxLines,
            onChanged: onChanged,
            validator: validator,
            // controller: controller,
            obscureText: isObscure ?? false,
            keyboardType: keyBoardType,
            decoration: InputDecoration(
                labelText: labelText,
                fillColor: Colors.white,
                filled: true,
                suffixIcon: suffixIcon,
                border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                hintText: hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black26, fontSize: 14),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(15))),
          )
        ],
      ),
    );
  }
}
