import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';
import 'package:pwa/features/chat/presentation/manager/get_messages_cubit/get_messages_cubit.dart';
import 'package:pwa/features/chat/presentation/views/widgets/received_msg_bubble.dart';
import 'package:pwa/features/chat/presentation/views/widgets/sender_msg_bubble.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMessagesCubit, GetMessagesState>(
      builder: (context, state) {
        if (state is GetMessagesSuccess) {
          final messages = state.messages;
          final currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
          
          if (messages.isNotEmpty) {
            return ListView.builder(
              reverse: true,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              itemCount: messages.length,
              itemBuilder: (context, index) =>
                  messages[index].senderEmail == currentUserEmail
                  ? SenderMsgBubble(
                      message: messages[index],
                    )
                  : ReceivedMsgBubble(
                      message: messages[index],
                      user: user,
                    ),
            );
          } else {
            return const Center(
              child: Text("Start Chatting..."),
            );
          }
        } else if (state is GetMessagesFailure) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return const Center(
            child: Text("Start Chatting..."),
          );
        }
      },
    );
  }
}
