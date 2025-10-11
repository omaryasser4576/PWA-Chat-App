import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwa/core/utils/colors_theme.dart';
import 'package:pwa/core/utils/styles.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';
import 'package:pwa/features/conversations/presentation/manager/create_chat_cubit/create_chat_cubit.dart';
import 'package:pwa/features/conversations/presentation/views/widgets/custom_user_image.dart';

class AddUserItem extends StatelessWidget {
  const AddUserItem({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: ColorsTheme.primaryLightColor),
        ),
      ),
      child: Row(
        children: [
          CustomUserImage(user: user),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  style: Styles.textStyle16,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  user.username,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.textStyle11,
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(60, 30),
              backgroundColor: ColorsTheme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: () {
              BlocProvider.of<CreateChatCubit>(
                context,
              ).createNewChat(userEmail: user.email);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(
                const SnackBar(
                  content: Text("Chat created..."),
                ),
              );
            },
            child: Text(
              '+ Add',
              style: Styles.textStyle11.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
