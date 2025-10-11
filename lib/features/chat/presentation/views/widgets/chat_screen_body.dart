import 'package:flutter/material.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';
import 'package:pwa/features/chat/presentation/views/widgets/chat_section.dart';
import 'package:pwa/features/chat/presentation/views/widgets/custom_chat_app_bar.dart';
import 'package:pwa/features/conversations/data/models/chat_model.dart';

class ChatScreenBody extends StatelessWidget {
  const ChatScreenBody({super.key, required this.chat, required this.user});
  final ChatModel chat;
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomChatAppBar( user: user,),
        Expanded(
          child: ChatSection(
            chat: chat,
            user: user,
          ),
        ),
      ],
    );
  }
}

