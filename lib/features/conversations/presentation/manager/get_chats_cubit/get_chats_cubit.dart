import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwa/features/conversations/data/models/chat_model.dart';
import 'package:pwa/features/conversations/data/repos/chats_repo/chats_repo.dart';

part 'get_chats_state.dart';

class GetChatsCubit extends Cubit<GetChatsState> {
  GetChatsCubit(this.chatsRepo) : super(GetChatsInitial());
  final ChatsRepo chatsRepo;
  StreamSubscription? _subscription;

  void getChats() {
    _subscription?.cancel();

    _subscription = chatsRepo.getChats().listen(
      (either) {
        either.fold(
          (failure) => emit(GetChatsFailure(failure.errorMessage)),
          (chats) => emit(GetChatsSuccess(chats)),
        );
      },
      onError: (error) {
        emit(GetChatsFailure(error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
