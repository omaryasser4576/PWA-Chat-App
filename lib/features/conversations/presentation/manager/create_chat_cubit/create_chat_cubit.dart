import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwa/features/conversations/data/repos/chats_repo/chats_repo.dart';

part 'create_chat_state.dart';

class CreateChatCubit extends Cubit<CreateChatState> {
  CreateChatCubit(this.chatsRepo) : super(CreateChatInitial());
  final ChatsRepo chatsRepo;

  Future<void> createNewChat({required String userEmail}) async {
    emit(CreateChatLoading());
    final res = await chatsRepo.createChat(userEmail: userEmail);
    res.fold(
      (failure) => emit(CreateChatFailure(failure.errorMessage)),
      (unit) => emit(CreateChatSuccess()),
    );
  }
}
