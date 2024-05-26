import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscure = false,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $hintText.';
        }
        return null;
      },
      obscureText: isObscure,
      obscuringCharacter: '*',
    );
  }
}
