part of 'get_users_cubit.dart';

sealed class GetUsersState {}

final class GetUsersInitial extends GetUsersState {}

final class GetUsersSuccess extends GetUsersState {
  final List<UserModel> users;

  GetUsersSuccess(this.users);
}

final class GetUsersLoading extends GetUsersState {}

final class GetUsersFailure extends GetUsersState {
  final String errorMessage;

  GetUsersFailure(this.errorMessage);
}

// for search

final class SearchUsersLoading extends GetUsersState {}

final class SearchUsersSuccess extends GetUsersState {
  final List<UserModel> users;

  SearchUsersSuccess(this.users);
}

final class SearchUsersEmpty extends GetUsersState {}
