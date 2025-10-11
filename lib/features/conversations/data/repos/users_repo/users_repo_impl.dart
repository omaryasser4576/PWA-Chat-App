import 'package:dartz/dartz.dart';
import 'package:pwa/core/errors/failure.dart';
import 'package:pwa/core/errors/get_data_failure.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';
import 'package:pwa/features/conversations/data/data_sources/users_remote_data_source/users_data_source.dart';
import 'package:pwa/features/conversations/data/repos/users_repo/users_repo.dart';

class UsersRepoImpl extends UsersRepo {
  final UsersDataSource usersDataSource;

  UsersRepoImpl(this.usersDataSource);
  @override
  Future<Either<Failure, List<UserModel>>> getUsers() async {
    try {
      final users = await usersDataSource.getUsers();
      return right(users);
    } catch (e) {
      return left(GetDataFailure(e.toString()));
    }
  }
}
