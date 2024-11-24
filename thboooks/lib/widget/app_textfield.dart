import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    this.hideText = false,
  });

  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final bool hideText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20, right: 20),
      child: TextField(
        obscureText: hideText,
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        cursorColor: const Color.fromARGB(255, 2, 2, 2),
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Color.fromARGB(255, 76, 72, 72)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Color.fromARGB(30, 73, 70, 70),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(100, 78, 76, 76),
            ),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          labelText: labelText,
        ),
      ),
    );
  }
}
