import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key,required this.hint, required this.controller});

  final String hint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Colors.grey,
        filled: true,
        hintText: hint
      ),
    );
  }
}
