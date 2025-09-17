import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  const CustomFormField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        filled: true,
        hintText: hintText,
        labelText: labelText,
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.red),
        ),
        errorStyle: TextStyle(color: Colors.red),
      ),
    );
  }
}
