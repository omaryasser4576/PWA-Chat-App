import 'package:firebase_auth/firebase_auth.dart';
import 'package:pwa/core/errors/failure.dart';

class AuthFailures extends Failure {
  const AuthFailures(super.errorMessage);
  factory AuthFailures.fromFirebase(FirebaseAuthException authException) {
    switch (authException.code) {
      case "invalid-email":
        return const AuthFailures("The email address is not valid.");

      case "user-disabled":
        return const AuthFailures("This account has been disabled.");

      case "user-not-found":
        return const AuthFailures("No user found with this email.");

      case "wrong-password":
        return const AuthFailures("The password is incorrect.");

      case "email-already-in-use":
        return const AuthFailures("This email is already registered.");

      case "weak-password":
        return const AuthFailures("Password is too weak.");

      case "operation-not-allowed":
        return const AuthFailures("This sign-in method is not allowed.");

      case "too-many-requests":
        return const AuthFailures("Too many attempts. Please try again later.");

      case "network-request-failed":
        return const AuthFailures(
          "Network error. Please check your connection.",
        );
      case "'invalid-credential'":
        return const AuthFailures("Invalid email or password.");
      default:
        return const AuthFailures(
          "An unexpected error occurred. Please try again.",
        );
    }
  }
}
