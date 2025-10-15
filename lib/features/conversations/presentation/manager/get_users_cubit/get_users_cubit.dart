import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';
import 'package:pwa/features/conversations/data/repos/users_repo/users_repo.dart';

part 'get_users_state.dart';

class GetUsersCubit extends Cubit<GetUsersState> {
  GetUsersCubit(this.usersRepo) : super(GetUsersInitial());
  final UsersRepo usersRepo;
  List<UserModel> usersList = [];
  Future<void> getUsers() async {
    emit(GetUsersLoading());
    final result = await usersRepo.getUsers();
    result.fold(
      (failure) {
        emit(GetUsersFailure(failure.errorMessage));
      },
      (users) {
        usersList = users;
        emit(GetUsersSuccess(users));
      },
    );
  }

  
}
