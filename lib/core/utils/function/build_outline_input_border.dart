import 'package:flutter/material.dart';

OutlineInputBorder buildOutlineInputBorder({double width = 1.0}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: Colors.black,
      width: width,
    ),
  );
}
