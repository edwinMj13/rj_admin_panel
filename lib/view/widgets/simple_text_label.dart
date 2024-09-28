import 'package:flutter/material.dart';

class SimpleTextLabel extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? errorLabel;
  const SimpleTextLabel({super.key,required this.controller,this.labelText,this.errorLabel});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(), labelText: labelText),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorLabel;
        }
        return null;
      },
    );
  }
}
