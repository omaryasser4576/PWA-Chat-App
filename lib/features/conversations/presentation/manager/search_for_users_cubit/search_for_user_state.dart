part of 'search_for_user_cubit.dart';

sealed class SearchForUserState {}

final class SearchForUserInitial extends SearchForUserState {}

final class SearchForUserLoading extends SearchForUserState {}

final class SearchForUserSuccess extends SearchForUserState {
  final List<UserModel> users;

  SearchForUserSuccess(this.users);
}

final class SearchForUserFailure extends SearchForUserState {
  final String errorMessage;

  SearchForUserFailure(this.errorMessage);
}
