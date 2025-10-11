import 'package:pwa/features/chat/data/models/message_model.dart';

abstract class MessagesRemoteDataSource {
  Future<void> sendMessage({required MessageModel message});
  Stream<List<MessageModel>> getChatMessages({required String chatId});
}
