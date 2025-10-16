import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pwa/core/utils/colors_theme.dart';
import 'package:pwa/core/utils/styles.dart';
import 'package:pwa/features/chat/data/models/message_model.dart';

class SenderMsgBubble extends StatefulWidget {
  const SenderMsgBubble({super.key, required this.message});
  final MessageModel message;

  @override
  State<SenderMsgBubble> createState() => _SenderMsgBubbleState();
}

class _SenderMsgBubbleState extends State<SenderMsgBubble> {
  final currentUserImage = FirebaseAuth.instance.currentUser?.photoURL;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: currentUserImage != null
                    ? NetworkImage(currentUserImage!)
                    : const AssetImage('assets/images/test.png'),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ColorsTheme.primaryLightColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    widget.message.message,
                    style: Styles.textStyle12.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "${widget.message.sendDate.hour}:${widget.message.sendDate.minute} ",
                  style: Styles.textStyle7,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
