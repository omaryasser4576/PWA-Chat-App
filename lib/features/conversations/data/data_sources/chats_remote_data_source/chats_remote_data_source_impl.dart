import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pwa/core/constants.dart';
import 'package:pwa/features/conversations/data/data_sources/chats_remote_data_source/chats_remote_data_source.dart';
import 'package:pwa/features/conversations/data/models/chat_model.dart';

class ChatsRemoteDataSourceImpl extends ChatsRemoteDataSource {
  final FirebaseFirestore firestore;

  ChatsRemoteDataSourceImpl(this.firestore);
  @override
  Future<void> createChat({required String userEmail}) async {
    final currentUser = FirebaseAuth.instance.currentUser;
   
      final newChat = ChatModel.createNew(
        partnersEmails: [
          currentUser!.email!,
          userEmail,
        ],
      );
      await firestore
          .collection(kChatsCollection)
          .doc(newChat.chatId)
          .set(newChat.toDatabase());
    
  }

  @override
  Stream<List<ChatModel>> getChats() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const Stream.empty();
    }
    final snapshots = firestore
        .collection(kChatsCollection)
        .orderBy('lastMessageDate', descending: true)
        .where('partnersEmails', arrayContains: currentUser.email)
        .snapshots();

    final chatsStream = snapshots.map((snapshot) {
      final chats = snapshot.docs.map((doc) {
        return ChatModel.fromDatabase(doc.data(), doc.id);
      }).toList();

      return chats;
    });

    return chatsStream;
  }
}
