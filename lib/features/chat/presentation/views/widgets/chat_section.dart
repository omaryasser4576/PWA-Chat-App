import 'package:flutter/material.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';
import 'package:pwa/features/chat/presentation/views/widgets/messages_list_view.dart';
import 'package:pwa/features/chat/presentation/views/widgets/send_msg_text_field.dart';
import 'package:pwa/features/conversations/data/models/chat_model.dart';

class ChatSection extends StatelessWidget {
  const ChatSection({
    super.key,
    required this.chat,
    required this.user,
  });
  final ChatModel chat;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: MessagesListView(
              user: user,
            ),
          ),
          SendMsgTextField(
            chat: chat,
          ),
        ],
      ),
    );
  }
}
