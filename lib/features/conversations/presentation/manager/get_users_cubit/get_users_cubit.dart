import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';
import 'package:pwa/features/conversations/data/repos/users_repo/users_repo.dart';

part 'get_users_state.dart';

class GetUsersCubit extends Cubit<GetUsersState> {
  GetUsersCubit(this.usersRepo) : super(GetUsersInitial());
  final UsersRepo usersRepo;
  Future<void> getUsers() async {
    emit(GetUsersLoading());
    print('Getting users...');
    final result = await usersRepo.getUsers();
    result.fold(
      (failure) {
        print('Failure: ${failure.errorMessage}');
        emit(GetUsersFailure(failure.errorMessage));
      },
      (users) {
        print('Users count: ${users.length}');
        emit(GetUsersSuccess(users));
      },
    );
  }
}
