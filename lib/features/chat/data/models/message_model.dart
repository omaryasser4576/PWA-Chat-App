import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String chatId;
  final String message;
  final DateTime sendDate;
  final String senderEmail;

  MessageModel({
    required this.chatId,
    required this.message,
    required this.sendDate,
    required this.senderEmail,
  });

  factory MessageModel.fromDatabase(dynamic data) {
    return MessageModel(
      chatId: data['chatId'],
      message: data['message'],
      sendDate: (data['sendDate'] as Timestamp).toDate(),
      senderEmail: data['senderEmail'],
    );
  }

  Map<String, dynamic> toDatabase() {
    return {
      'chatId': chatId,
      'senderEmail': senderEmail,
      'message': message,
      'sendDate': Timestamp.fromDate(sendDate),
    };
  }
}
