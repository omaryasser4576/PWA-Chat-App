import 'package:flutter/material.dart';
import 'package:pwa/core/utils/colors_theme.dart';
import 'package:pwa/core/utils/styles.dart';

class TitleItem extends StatelessWidget {
  const TitleItem({
    super.key,
    required this.title,
    required this.icon,
    this.selected = true,
  });
  final String title;
  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: selected
              ? Border(
                  bottom: BorderSide(
                    color: ColorsTheme.primaryColor,
                    width: 2,
                  ),
                )
              : null,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: selected ? ColorsTheme.primaryColor : Colors.black,
                size: 28,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: Styles.textStyle14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
