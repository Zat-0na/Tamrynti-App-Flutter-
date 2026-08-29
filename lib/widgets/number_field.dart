import 'package:flutter/material.dart';

class NumberField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const NumberField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14),

        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            controller.clear();
          },
        ),

        border: const OutlineInputBorder(),
      ),
    );
  }
}
