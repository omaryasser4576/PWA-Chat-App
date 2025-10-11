import 'package:dartz/dartz.dart';
import 'package:pwa/core/errors/failure.dart';
import 'package:pwa/core/errors/get_data_failure.dart';
import 'package:pwa/features/conversations/data/data_sources/chats_remote_data_source/chats_remote_data_source.dart';
import 'package:pwa/features/conversations/data/models/chat_model.dart';
import 'package:pwa/features/conversations/data/repos/chats_repo/chats_repo.dart';

class ChatsRepoImpl extends ChatsRepo {
  final ChatsRemoteDataSource chatsDataSource;

  ChatsRepoImpl(this.chatsDataSource);
  @override
  Future<Either<Failure, Unit>> createChat({required String userEmail}) async {
    try {
      await chatsDataSource.createChat(userEmail: userEmail);
      return right(unit);
    } catch (e) {
      return left(GetDataFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<ChatModel>>> getChats() async* {
    try {
      await for (final chats in chatsDataSource.getChats()) {
        yield right(chats);
      }
    } catch (e) {
      yield left(GetDataFailure(e.toString()));
    }
  }
}
