import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pwa/core/utils/app_router.dart';
import 'package:pwa/core/utils/colors_theme.dart';

class AddUserFloatingButton extends StatelessWidget {
  const AddUserFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorsTheme.primaryColor,
      onPressed: () {
        GoRouter.of(context).push(AppRouter.addUserScreen);
      },
      child: const Icon(
        Icons.person_add_alt_outlined,
        color: Colors.white,
      ),
    );
  }
}
