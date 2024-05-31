import 'package:flutter/material.dart';

class TextFieldWLabel extends StatelessWidget {
  final String label;
  final bool required;
  final TextEditingController controller;
  const TextFieldWLabel(
      {super.key,
      required this.label,
      required this.required,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                // letterSpacing: 1.2,
              ),
            ),
            const SizedBox(width: 8.0),
            required
                ? const Text(
                    "*",
                    style: TextStyle(color: Colors.red), // Customize color here
                  )
                : const SizedBox(),
          ],
        ),
        Container(
          height: 40,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            validator: required
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  }
                : null,
            controller: controller,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.amber.shade700), // Set the border color here
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black), // Set the border color here
              ),
            ),
          ),
        ),
      ],
    );
  }
}
