import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:pwa/features/auth/data/data_sources/auth_data_source_impl.dart';
import 'package:pwa/features/chat/data/data_sources/messages_data_source/messages_remote_data_source_impl.dart';
import 'package:pwa/features/chat/data/repos/messages_repo/messages_repo_impl.dart';
import 'package:pwa/features/conversations/data/data_sources/chats_remote_data_source/chats_remote_data_source_impl.dart';
import 'package:pwa/features/conversations/data/data_sources/users_remote_data_source/users_data_source_impl.dart';
import 'package:pwa/features/conversations/data/repos/chats_repo/chats_repo_impl.dart';
import 'package:pwa/features/conversations/data/repos/users_repo/users_repo_impl.dart';

GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  //auth
  getIt.registerSingleton<AuthDataSourceImpl>(
    AuthDataSourceImpl(
      getIt.get<FirebaseAuth>(),
      getIt.get<FirebaseFirestore>(),
    ),
  );
  // get users
  getIt.registerSingleton<UsersDataSourceImpl>(
    UsersDataSourceImpl(
      getIt.get<FirebaseFirestore>(),
    ),
  );
  getIt.registerSingleton<UsersRepoImpl>(
    UsersRepoImpl(
      getIt.get<UsersDataSourceImpl>(),
    ),
  );
  // chats
  getIt.registerSingleton<ChatsRemoteDataSourceImpl>(
    ChatsRemoteDataSourceImpl(
      getIt.get<FirebaseFirestore>(),
    ),
  );
  getIt.registerSingleton<ChatsRepoImpl>(
    ChatsRepoImpl(
      getIt.get<ChatsRemoteDataSourceImpl>(),
    ),
  );

  getIt.registerSingleton<MessagesRemoteDataSourceImpl>(
    MessagesRemoteDataSourceImpl(
      getIt.get<FirebaseFirestore>(),
    ),
  );
  getIt.registerSingleton<MessagesRepoImpl>(
    MessagesRepoImpl(
      getIt.get<MessagesRemoteDataSourceImpl>(),
    ),
  );
}
