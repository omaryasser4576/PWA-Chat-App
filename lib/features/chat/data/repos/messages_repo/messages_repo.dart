import 'package:dartz/dartz.dart';
import 'package:pwa/core/errors/failure.dart';
import 'package:pwa/features/chat/data/models/message_model.dart';

abstract class MessagesRepo {
  Future<Either<Failure, Unit>> sendMessage({required MessageModel message});
  Stream<Either<Failure,List<MessageModel>>> getChatMessages({required String chatId});
}