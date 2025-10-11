import 'package:dartz/dartz.dart';
import 'package:pwa/core/errors/failure.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<Either<Failure, Unit>> createAccountWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserModel>> completeProfile({
    required String fullName,
    required String username,
    String? userImage,
  });

  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });
}
