import 'package:flutter/material.dart';
import 'package:pwa/core/utils/colors_theme.dart';
import 'package:pwa/core/utils/styles.dart';

class CustomLabeledTextButton extends StatelessWidget {
  const CustomLabeledTextButton({super.key, required this.label, required this.text, this.onTap});

  final String label;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: Styles.textStyle12,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            text,
            style: Styles.textStyle12.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorsTheme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
