import 'package:pwa/features/auth/data/models/user_model.dart';

abstract class UsersDataSource {
  Future<List<UserModel>> getUsers();
}
