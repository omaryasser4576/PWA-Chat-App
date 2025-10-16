import 'package:flutter/material.dart';
import 'package:pwa/core/utils/colors_theme.dart';
import 'package:pwa/core/utils/styles.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';
import 'package:pwa/features/chat/data/models/message_model.dart';

class ReceivedMsgBubble extends StatelessWidget {
  const ReceivedMsgBubble({
    super.key,
    required this.message,
    required this.user,
  });
  final MessageModel message;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ColorsTheme.primaryShadeDark,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      topLeft: Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    message.message,
                    style: Styles.textStyle12.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "${message.sendDate.hour}:${message.sendDate.minute} ",
                  style: Styles.textStyle7,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: user.userImage != null
                    ? NetworkImage(
                        user.userImage!,
                      )
                    : const AssetImage(
                        'assets/images/test.png',
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
