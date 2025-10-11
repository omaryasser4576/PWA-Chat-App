import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pwa/core/constants.dart';
import 'package:pwa/features/chat/data/data_sources/messages_data_source/messages_remote_data_source.dart';
import 'package:pwa/features/chat/data/models/message_model.dart';

class MessagesRemoteDataSourceImpl extends MessagesRemoteDataSource {
  final FirebaseFirestore firestore;

  MessagesRemoteDataSourceImpl(this.firestore);
  @override
  Stream<List<MessageModel>> getChatMessages({required String chatId}) {
    final collection = firestore
        .collection(kMessagesCollection)
        .where('chatId', isEqualTo: chatId)
        .orderBy('sendDate', descending: true);
    final snapshots = collection.snapshots();
    final messageStreaming = snapshots.map(
      (snapshot) {
        final messages = snapshot.docs.map(
          (doc) {
            return MessageModel.fromDatabase(doc);
          },
        ).toList();
        return messages;
      },
    );
    return messageStreaming;
  }

  @override
  Future<void> sendMessage({required MessageModel message}) async {
    final chatRef = firestore.collection(kChatsCollection).doc(message.chatId);
    await firestore.collection(kMessagesCollection).add(message.toDatabase());

    await chatRef.update({
      'lastMessage': message.message,
      'lastMessageSender': message.senderEmail,
      'lastMessageDate': message.sendDate,
    });
  }
}
