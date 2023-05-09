import 'package:flutter/material.dart';

class InputDecorations {

  static InputDecoration authInputDecoration({
    required String labelText,
    required String hintText,
    IconData? prefixIcon
  }) => InputDecoration(
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.deepPurple
          )
      ),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.deepPurple,
              width: 2
          )
      ),
      labelText: labelText,
      labelStyle: const TextStyle(
          color: Colors.grey
      ),
      hintText: hintText,
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: Colors.deepPurple)
          : null
  );

}