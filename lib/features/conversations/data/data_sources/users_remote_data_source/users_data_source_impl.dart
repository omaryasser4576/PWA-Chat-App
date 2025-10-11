import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pwa/core/constants.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';
import 'package:pwa/features/conversations/data/data_sources/users_remote_data_source/users_data_source.dart';

class UsersDataSourceImpl extends UsersDataSource {
  final FirebaseFirestore fireStore;

  UsersDataSourceImpl(this.fireStore);
  @override
  Future<List<UserModel>> getUsers() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      print('⚠️ No current user found in getUsers()');
      return [];
    }

    final querySnapshot = await fireStore.collection(kUsersCollection).get();

    final users = querySnapshot.docs
        .where((doc) => doc.id != currentUser.uid)
        .map((doc) => UserModel.fromDatabase(doc.data()))
        .toList();
    return users;
  }
}
