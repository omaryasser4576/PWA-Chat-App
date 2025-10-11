import 'package:uuid/uuid.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String username;
  final String? userImage;
  final String email;

  UserModel({
    required this.fullName,
    required this.username,
    required this.userImage,
    required this.email,
  }) : uid = const Uuid().v8();

  factory UserModel.fromDatabase(dynamic data) {
    return UserModel(
      fullName: data['fullName'],
      username: data['username'],
      userImage: data['userImage'],
      email: data['email'],
    );
  }

  Map<String, dynamic> toDatabase() {
    return {
      'id': uid,
      'fullName': fullName,
      'username': username,
      'userImage': userImage,
      'email': email,
    };
  }
}
