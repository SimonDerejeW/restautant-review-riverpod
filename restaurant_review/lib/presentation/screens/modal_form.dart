import 'package:flutter/material.dart';
import 'package:restaurant_review/presentation/widgets/modal_form_text_field.dart';

class Modal extends StatelessWidget {
  const Modal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const Text(
                    'Contact information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const TextFieldWLabel(
                    label: "City",
                    required: true,
                  ),
                  const TextFieldWLabel(
                    label: "Address",
                    required: true,
                  ),
                  const SizedBox(height: 12.0),
                  const Text(
                    'Availableness',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  const TextFieldWLabel(
                    label: "Opening days",
                    required: true,
                  ),
                  const TextFieldWLabel(
                    label: "Opening hours",
                    required: true,
                  ),
                  const SizedBox(height: 12.0),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  const TextFieldWLabel(
                    label: "Description (optional)",
                    required: false,
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Add image',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                            ),
                            color: Color.fromRGBO(228, 158, 38, 1),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                        Container(
                          height: 48.0,
                          width: 120.0,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                            color: Color.fromARGB(255, 245, 221, 151),
                          ),
                          child: Center(
                            child: Text(
                              "Add image",
                              style: TextStyle(color: Colors.amber.shade700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    height: 50,
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 245, 149, 24),
                        shadowColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 32.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
