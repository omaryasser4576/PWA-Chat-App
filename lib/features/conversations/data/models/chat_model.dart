import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ChatModel {
  final String chatId;
  final List<String> partnersEmails;
  final String? userName;
  final String? lastMessage;
  final DateTime? lastMessageDate;

  ChatModel({
    required this.chatId,
    required this.partnersEmails,
    this.userName,
    this.lastMessage,
    this.lastMessageDate,
  });

  factory ChatModel.createNew({
    required List<String> partnersEmails,
    String? lastMessage,
    DateTime? lastMessageDate,
    String? userName,
  }) {
    return ChatModel(
      chatId: const Uuid().v8(),
      partnersEmails: partnersEmails,
      lastMessage: lastMessage,
      lastMessageDate: lastMessageDate,
      userName: userName,
    );
  }

  factory ChatModel.fromDatabase(Map<String, dynamic> data, String id) {
    return ChatModel(
      chatId: id,
      partnersEmails: List<String>.from(data['partnersEmails'] ?? []),
      userName: data['userName'],
      lastMessage: data['lastMessage'],
      lastMessageDate: data['lastMessageDate'] != null
          ? (data['lastMessageDate'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toDatabase() {
    return {
      'partnersEmails': partnersEmails,
      'userName': userName,
      'lastMessage': lastMessage,
      'lastMessageDate': lastMessageDate != null
          ? Timestamp.fromDate(lastMessageDate!)
          : null,
    };
  }
}
