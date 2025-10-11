import 'package:flutter/material.dart';
import 'package:pwa/features/conversations/presentation/views/widgets/chats_list_view.dart';
import 'package:pwa/features/conversations/presentation/views/widgets/conversation_app_bar.dart';

class ConversationsScreenBody extends StatelessWidget {
  const ConversationsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ConversationAppBar(),
        SizedBox(height: 4),
        Expanded(child: ChatsListView()),
      ],
    );
  }
}
