part of 'get_chats_cubit.dart';

sealed class GetChatsState {}

final class GetChatsInitial extends GetChatsState {}

final class GetChatsSuccess extends GetChatsState {
  final List<ChatModel> chats;

  GetChatsSuccess(this.chats);
}

final class GetChatsLoading extends GetChatsState {}

final class GetChatsFailure extends GetChatsState {
  final String errorMessage;

  GetChatsFailure(this.errorMessage);
}
