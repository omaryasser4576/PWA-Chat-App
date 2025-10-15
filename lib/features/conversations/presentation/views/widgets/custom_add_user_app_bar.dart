import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pwa/core/utils/colors_theme.dart';
import 'package:pwa/core/utils/styles.dart';
import 'package:pwa/core/widgets/custom_icon_button.dart';
import 'package:pwa/features/conversations/presentation/views/widgets/search_for_user_text_field.dart';

class CustomAddUserAppBar extends StatefulWidget {
  const CustomAddUserAppBar({super.key});

  @override
  State<CustomAddUserAppBar> createState() => _CustomAddUserAppBarState();
}

class _CustomAddUserAppBarState extends State<CustomAddUserAppBar> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      padding: const EdgeInsets.only(top: 28, left: 12, right: 12),
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
          isSearching
              ? const Expanded(
                  child: SearchForUserTextField(),
                )
              : Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Add Contact ',
                        style: Styles.textStyle22.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      CustomIconButton(
                        icon: Icons.search,
                        onPressed: () {
                          setState(() {
                            isSearching = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
