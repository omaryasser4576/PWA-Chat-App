import 'package:flutter/material.dart';
import 'package:pwa/core/utils/colors_theme.dart';
import 'package:pwa/core/utils/function/build_outline_input_border.dart';
import 'package:pwa/core/utils/styles.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({super.key, this.hint, this.onChanged});

  final String? hint;
  final void Function(String)? onChanged;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'The password is required.';
        } else if (value.trim().length < 8) {
          return 'Must be 8 letters or more';
        }
        return null;
      },
      obscureText: showPassword,
      decoration: InputDecoration(
        label: const Text(
          "Password",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        hintText: widget.hint,
        hintStyle: Styles.textStyle16.copyWith(
          color: ColorsTheme.hintTextColor,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: const Icon(
          Icons.password_rounded,
          color: Colors.black,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
          icon: Icon(
            showPassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
        ),
        border: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(width: 2),
      ),
    );
  }
}
