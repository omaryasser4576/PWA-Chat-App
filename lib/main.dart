import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwa/core/constants.dart';
import 'package:pwa/core/helper/auth_local_storage.dart';
import 'package:pwa/core/utils/app_router.dart';
import 'package:pwa/core/utils/service_locatore.dart';
import 'package:pwa/features/auth/data/data_sources/auth_data_source_impl.dart';
import 'package:pwa/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pwa/features/conversations/data/repos/chats_repo/chats_repo_impl.dart';
import 'package:pwa/features/conversations/data/repos/users_repo/users_repo_impl.dart';
import 'package:pwa/features/conversations/presentation/manager/get_chats_cubit/get_chats_cubit.dart';
import 'package:pwa/features/conversations/presentation/manager/get_users_cubit/get_users_cubit.dart';
import 'package:pwa/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppRouter.isLogged = await AuthLocalStorage.isUserLoggedIn();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Supabase.initialize(
    url: kSupabaseUrl,
    anonKey: kSupabaseKey,
  );

  setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
            getIt.get<AuthDataSourceImpl>(),
          )..checkCurrentUser(),
        ),
        BlocProvider(
          create: (context) => GetUsersCubit(
            getIt.get<UsersRepoImpl>(),
          ),
        ),
        BlocProvider(
          create: (context) => GetChatsCubit(
            getIt.get<ChatsRepoImpl>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'PWA',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: kSoraFont,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
