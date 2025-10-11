import 'package:pwa/features/conversations/data/models/chat_model.dart';

abstract class ChatsRemoteDataSource {
  Stream<List<ChatModel>> getChats();
  Future<void> createChat({required String userEmail});
}
