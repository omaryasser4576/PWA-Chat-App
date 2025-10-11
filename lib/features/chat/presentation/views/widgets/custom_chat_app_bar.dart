import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pwa/core/utils/colors_theme.dart';
import 'package:pwa/core/utils/styles.dart';
import 'package:pwa/core/widgets/custom_icon_button.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';

class CustomChatAppBar extends StatelessWidget {
  const CustomChatAppBar({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 32, bottom: 8),
      decoration: BoxDecoration(
        color: ColorsTheme.primaryLightColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomIconButton(
            icon: Icons.arrow_back,
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                Text(
                  user.fullName,
                  style: Styles.textStyle22.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  user.username,
                  style: Styles.textStyle16.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: null,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          const CustomIconButton(icon: Icons.notifications_active),
          const CustomIconButton(icon: Icons.more_vert),
        ],
      ),
    );
  }
}
