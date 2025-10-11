import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pwa/core/constants.dart';
import 'package:pwa/core/errors/auth_failures.dart';
import 'package:pwa/core/errors/failure.dart';
import 'package:pwa/core/utils/function/upload_user_image.dart';
import 'package:pwa/features/auth/data/data_sources/auth_data_source.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthDataSourceImpl(this.firebaseAuth, this.firestore);

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = firebaseAuth.currentUser;
      final doc = await firestore
          .collection(kUsersCollection)
          .doc(user?.uid)
          .get();
      if (!doc.exists) {
        return left(const AuthFailures("User data not found in database."));
      }
      return right(UserModel.fromDatabase(doc.data()));
    } catch (e) {
      if (e is FirebaseAuthException) {
        return left(AuthFailures.fromFirebase(e));
      }
      return left(const AuthFailures("Unexpected error, try again."));
    }
  }

  @override
  Future<Either<Failure, Unit>> createAccountWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(unit);
    } catch (e) {
      if (e is FirebaseAuthException) {
        return left(AuthFailures.fromFirebase(e));
      }
      return left(const AuthFailures("Unexpected error, try again."));
    }
  }

  @override
  Future<Either<Failure, UserModel>> completeProfile({
    required String fullName,
    required String username,
    String? userImage,
  }) async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser == null) {
        return left(const AuthFailures("No user logged in."));
      }

      String? uploadUserImage;
      if (userImage != null) {
        final file = File(userImage);
        uploadUserImage = await uploadUserImageToSupabase(
          file,
        );
      }

      final user = UserModel(
        fullName: fullName,
        username: username,
        userImage: uploadUserImage,
        email: currentUser.email!,
      );

      await firestore
          .collection(kUsersCollection)
          .doc(currentUser.uid)
          .set(user.toDatabase());

      return right(user);
    } catch (e) {
      if (e is FirebaseAuthException) {
        return left(AuthFailures.fromFirebase(e));
      }
      return left(const AuthFailures("Unexpected error, try again."));
    }
  }
}
