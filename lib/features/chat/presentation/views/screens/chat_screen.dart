import 'package:flutter/material.dart';
import 'package:pwa/core/utils/colors_theme.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';
import 'package:pwa/features/chat/presentation/views/widgets/chat_screen_body.dart';
import 'package:pwa/features/conversations/data/models/chat_model.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.chat, required this.user});
  final ChatModel chat;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme.primaryLightColor,
      body: ChatScreenBody(
        chat: chat,
        user: user,
      ),
    );
  }
}
