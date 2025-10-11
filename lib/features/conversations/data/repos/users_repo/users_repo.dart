import 'package:dartz/dartz.dart';
import 'package:pwa/core/errors/failure.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';

abstract class UsersRepo {
  Future<Either<Failure, List<UserModel>>> getUsers();
}
