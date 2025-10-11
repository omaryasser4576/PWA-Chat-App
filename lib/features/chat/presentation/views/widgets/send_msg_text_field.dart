import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pwa/core/utils/colors_theme.dart';
import 'package:pwa/core/utils/styles.dart';
import 'package:pwa/features/chat/data/models/message_model.dart';
import 'package:pwa/features/chat/presentation/manager/send_message_cubit/send_message_cubit.dart';
import 'package:pwa/features/conversations/data/models/chat_model.dart';

class SendMsgTextField extends StatefulWidget {
  const SendMsgTextField({
    super.key,
    required this.chat,
  });
  final ChatModel chat;

  @override
  State<SendMsgTextField> createState() => _SendMsgTextFieldState();
}

class _SendMsgTextFieldState extends State<SendMsgTextField> {
  final TextEditingController _controller = TextEditingController();

  String? message;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 18, top: 8, right: 18, bottom: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          message = value;
        },
        decoration: InputDecoration(
          hintText: 'Type message here...',
          hintStyle: Styles.textStyle14.copyWith(
            fontWeight: FontWeight.normal,
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.faceSmile),
          ),
          suffixIcon: GestureDetector(
            onTap: () async {
              if (message != null && message!.trim().isNotEmpty) {
                await sendMessage(context);
              }
            },
            child: Container(
              padding: const EdgeInsets.only(top: 4, right: 4),
              width: 46,
              height: 46,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: ColorsTheme.primaryColor,
              ),
              child: Image.asset('assets/icons/send.png'),
            ),
          ),
          border: outlineBorder(),
          focusedBorder: outlineBorder(),
          enabledBorder: outlineBorder(),
        ),
      ),
    );
  }

  Future<void> sendMessage(BuildContext context) async {
    final currentUserEmail = FirebaseAuth.instance.currentUser?.email;
    final MessageModel messageModel = MessageModel(
      chatId: widget.chat.chatId,
      message: message!,
      sendDate: DateTime.now(),
      senderEmail: currentUserEmail!,
    );
    await BlocProvider.of<SendMessageCubit>(
      context,
    ).sendMessage(message: messageModel);
    _controller.clear();
    setState(() {
      message = null;
    });
  }

  OutlineInputBorder outlineBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(
        color: Colors.white,
      ),
    );
  }
}
