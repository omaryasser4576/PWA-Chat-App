import 'package:flutter/material.dart';
import 'package:pwa/core/utils/colors_theme.dart';
import 'package:pwa/core/utils/styles.dart';
import 'package:pwa/features/conversations/presentation/views/widgets/custom_search_text_field.dart';

class ConversationAppBar extends StatelessWidget {
  const ConversationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 31, right: 31, top: 48, bottom: 25),
      decoration: BoxDecoration(
        color: ColorsTheme.primaryLightColor,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "CHATS",
            style: Styles.textStyle24.copyWith(
              fontFamily: null,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 18),

          const CustomSearchTextField(),
        ],
      ),
    );
  }
}
