import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pwa/core/utils/app_router.dart';
import 'package:pwa/core/utils/colors_theme.dart';
import 'package:pwa/core/utils/styles.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';
import 'package:pwa/features/conversations/data/models/chat_model.dart';
import 'package:pwa/features/conversations/presentation/manager/get_users_cubit/get_users_cubit.dart';
import 'package:pwa/features/conversations/presentation/views/widgets/custom_user_image.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.chat,
  });
  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUsersCubit, GetUsersState>(
      builder: (context, state) {
        if (state is GetUsersSuccess) {
          final usersList = state.users;

          final UserModel user = getUserDataByEmail(usersList);

          return GestureDetector(
            onTap: () {
              GoRouter.of(context).push(
                AppRouter.chatScreen,
                extra: {
                  'chat': chat,
                  'user': user,
                },
              );
            },
            child: Container(
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
                          chat.lastMessage ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.textStyle11,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '10 min',
                        style: Styles.textStyle10,
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: ColorsTheme.primaryColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            '2',
                            style: Styles.textStyle11.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: Text("adsad"),
          );
        }
      },
    );
  }

  UserModel getUserDataByEmail(List<UserModel> usersList) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final partnerEmail = chat.partnersEmails.firstWhere(
      (email) => email != currentUser!.email,
    );

    final UserModel user = usersList.firstWhere(
      (u) => u.email == partnerEmail,
    );
    return user;
  }
}
