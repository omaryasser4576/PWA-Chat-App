import 'package:dartz/dartz.dart';
import 'package:pwa/core/errors/failure.dart';
import 'package:pwa/core/errors/get_data_failure.dart';
import 'package:pwa/features/chat/data/data_sources/messages_data_source/messages_remote_data_source.dart';
import 'package:pwa/features/chat/data/models/message_model.dart';
import 'package:pwa/features/chat/data/repos/messages_repo/messages_repo.dart';

class MessagesRepoImpl extends MessagesRepo {
  final MessagesRemoteDataSource messagesDataSource;

  MessagesRepoImpl(this.messagesDataSource);

  @override
  Stream<Either<Failure, List<MessageModel>>> getChatMessages({
    required String chatId,
  }) async* {
    try {
      await for (final messages in messagesDataSource.getChatMessages(
        chatId: chatId,
      )) {
        yield right(messages);
      }
    } catch (e) {
      yield left(GetDataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendMessage({
    required MessageModel message,
  }) async {
    try {
      await messagesDataSource.sendMessage(message: message);
      return right(unit);
    } catch (e) {
      return left(GetDataFailure(e.toString()));
    }
  }
}
