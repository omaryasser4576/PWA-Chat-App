import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwa/features/chat/data/models/message_model.dart';
import 'package:pwa/features/chat/data/repos/messages_repo/messages_repo.dart';

part 'get_messages_state.dart';

class GetMessagesCubit extends Cubit<GetMessagesState> {
  GetMessagesCubit(this.messagesRepo) : super(GetMessagesInitial());
  final MessagesRepo messagesRepo;
  StreamSubscription? subscription;

  void getChatMessages({required String chatId}) {
    emit(GetMessagesLoading());
    subscription?.cancel(); 
    subscription = messagesRepo
        .getChatMessages(chatId: chatId)
        .listen(
          (either) {
            either.fold(
              (failure) => emit(GetMessagesFailure(failure.errorMessage)),
              (messages) => emit(GetMessagesSuccess(messages)),
            );
          },
          onError: (error) {
            emit(GetMessagesFailure(error.toString()));
          },
        );
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
