import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwa/core/helper/auth_local_storage.dart';
import 'package:pwa/core/utils/app_router.dart';
import 'package:pwa/features/auth/data/data_sources/auth_data_source.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this.authDataSource) : super(AuthInitial());

  final AuthDataSource authDataSource;

  Future<void> checkCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      emit(AuthAlreadyLoggedIn());
    } else {
      emit(AuthLoggedOut());
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoginLoading());
    final result = await authDataSource.login(
      email: email,
      password: password,
    );
    result.fold(
      (failure) {
        emit(AuthFailure(failure.errorMessage));
      },
      (user) {
        setLoggedIn();
        AppRouter.isLogged = true;
        emit(AuthLoginSuccess(user));
      },
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthSignInLoading());
    final result = await authDataSource.createAccountWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold(
      (failure) {
        emit(AuthFailure(failure.errorMessage));
      },
      (unit) {
        emit(AuthSignInSuccess());
      },
    );
  }

  Future<void> completeProfile({
    required String fullName,
    required String username,
    String? userImage,
  }) async {
    emit(AuthCompleteProfileLoading());
    final result = await authDataSource.completeProfile(
      fullName: fullName,
      username: username,
      userImage: userImage,
    );
    result.fold(
      (failure) {
        emit(AuthFailure(failure.errorMessage));
      },
      (user) {
        setLoggedIn();
        AppRouter.isLogged = true;
        emit(AuthCompleteProfileSuccess(user));
      },
    );
  }

  void setLoggedIn() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await AuthLocalStorage.saveUserLoggedIn(currentUser.uid);
    }
  }
}
