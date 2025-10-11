import 'package:dartz/dartz.dart';
import 'package:pwa/core/errors/failure.dart';
import 'package:pwa/features/conversations/data/models/chat_model.dart';

abstract class ChatsRepo {
  Stream<Either<Failure, List<ChatModel>>> getChats();
  Future<Either<Failure, Unit>> createChat({required String userEmail});
}
