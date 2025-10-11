import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwa/features/chat/data/models/message_model.dart';
import 'package:pwa/features/chat/data/repos/messages_repo/messages_repo.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit(this.messagesRepo) : super(SendMessageInitial());
  final MessagesRepo messagesRepo;

  Future<void> sendMessage({required MessageModel message}) async {
    emit(SendMessageLoading());
    final res = await messagesRepo.sendMessage(message: message);
    res.fold(
      (failure) => emit(SendMessageFailure(failure.errorMessage)),
      (unit) => emit(SendMessageSuccess()),
    );
  }
}
