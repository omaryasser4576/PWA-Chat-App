import 'package:flutter/material.dart';
import 'package:pwa/core/utils/colors_theme.dart';
import 'package:pwa/core/utils/function/build_outline_input_border.dart';
import 'package:pwa/core/utils/styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    this.icon,
    this.hint,
    this.keyboardType,
    this.iconImage,
    this.onChanged,
    this.validator,
  });
  final String label;
  final IconData? icon;
  final String? hint;
  final TextInputType? keyboardType;
  final String? iconImage;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        label: Text(
          label,
          style: const TextStyle(color: Colors.black),
        ),
        hintText: hint,
        hintStyle: Styles.textStyle16.copyWith(
          color: ColorsTheme.hintTextColor,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: Colors.black,
              )
            : iconImage != null
            ? Image.asset(iconImage!)
            : null,
        border: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(width: 2),
      ),
    );
  }
}
