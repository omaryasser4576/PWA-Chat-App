import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';

part 'search_for_user_state.dart';

class SearchForUserCubit extends Cubit<SearchForUserState> {
  SearchForUserCubit() : super(SearchForUserInitial());

  List<UserModel> usersList = [];
  List<UserModel> searchedUsers = [];
  void searchForUsersByUsername({required String username}) {
    if (usersList.isEmpty) {
      return;
    }
    if (username.isEmpty || username.trim().isEmpty) {
      return;
    }
    emit(SearchForUserLoading());
    searchedUsers = usersList
        .where(
          (user) => user.username.contains(username),
        )
        .toList();
    emit(SearchForUserSuccess(searchedUsers));
  }
}
