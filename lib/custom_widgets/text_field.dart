import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  void Function()? onTap;
  void Function(String)? onChanged;
  final String hint;
  Widget? suffix;
  Widget prefix;
  bool obscureText;
  TextEditingController controller;
  String? Function(String?)? validator;

  CustomTextField(
      {required this.hint,
      this.obscureText = false,
      required this.prefix,
      @required this.onTap,
      @required this.onChanged,
      @required this.suffix,
      required this.controller,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 10, color: Colors.red)),
        hintText: hint,
        prefixIcon: prefix,
        suffixIcon: suffix,
      ),
    );
  }
}
