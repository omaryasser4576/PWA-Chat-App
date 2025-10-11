part of 'send_message_cubit.dart';

sealed class SendMessageState {}

final class SendMessageInitial extends SendMessageState {}

final class SendMessageLoading extends SendMessageState {}

final class SendMessageFailure extends SendMessageState {
  final String errorMessage;

  SendMessageFailure(this.errorMessage);
}

final class SendMessageSuccess extends SendMessageState {}
