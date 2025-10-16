import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwa/features/conversations/data/models/chat_model.dart';
import 'package:pwa/features/conversations/presentation/manager/get_chats_cubit/get_chats_cubit.dart';
import 'package:pwa/features/conversations/presentation/views/widgets/chat_item.dart';
import 'package:pwa/features/conversations/presentation/views/widgets/chat_item_shimmer_loading.dart';

class ChatsListView extends StatelessWidget {
  const ChatsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetChatsCubit, GetChatsState>(
      builder: (context, state) {
        if (state is GetChatsSuccess) {
          final List<ChatModel> chats = state.chats;
          if (chats.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: chats.length,
              itemBuilder: (context, index) => ChatItem(
                chat: chats[index],
              ),
            );
          } else {
            return const Center(
              child: Text('Start chatting with your friends...'),
            );
          }
        } else if (state is GetChatsLoading) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 3,
            itemBuilder: (context, index) => const ChatItemShimmerLoading(),
          );
        } else if (state is GetChatsFailure) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return const Center(
            child: Text(''),
          );
        }
      },
    );
  }
}
