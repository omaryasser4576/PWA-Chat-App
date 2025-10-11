import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pwa/core/utils/colors_theme.dart';
import 'package:pwa/core/utils/styles.dart';
import 'package:pwa/core/widgets/custom_icon_button.dart';

class CustomAddUserAppBar extends StatelessWidget {
  const CustomAddUserAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(top: 24, left: 12, right: 12),
      decoration: BoxDecoration(
        color: ColorsTheme.primaryLightColor,
      ),
      child: Row(
        children: [
          CustomIconButton(
            icon: Icons.arrow_back,
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
          const SizedBox(width: 6),
          Text(
            'Add Contact ',
            style: Styles.textStyle22.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          const CustomIconButton(
            icon: Icons.search,
          ),
        ],
      ),
    );
  }
}
