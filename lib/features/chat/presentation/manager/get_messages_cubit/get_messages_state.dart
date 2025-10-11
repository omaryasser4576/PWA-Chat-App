part of 'get_messages_cubit.dart';

sealed class GetMessagesState {}

final class GetMessagesInitial extends GetMessagesState {}

final class GetMessagesLoading extends GetMessagesState {}

final class GetMessagesFailure extends GetMessagesState {
  final String errorMessage;

  GetMessagesFailure(this.errorMessage);
}

final class GetMessagesSuccess extends GetMessagesState {
  final List<MessageModel> messages;

  GetMessagesSuccess(this.messages);
}
