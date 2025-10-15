import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pwa/core/utils/service_locatore.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';
import 'package:pwa/features/auth/presentation/views/screens/login_screen.dart';
import 'package:pwa/features/auth/presentation/views/screens/signin_personal_screen.dart';
import 'package:pwa/features/auth/presentation/views/screens/signin_screen.dart';
import 'package:pwa/features/chat/data/repos/messages_repo/messages_repo_impl.dart';
import 'package:pwa/features/chat/presentation/manager/get_messages_cubit/get_messages_cubit.dart';
import 'package:pwa/features/chat/presentation/manager/send_message_cubit/send_message_cubit.dart';
import 'package:pwa/features/chat/presentation/views/screens/chat_screen.dart';
import 'package:pwa/features/conversations/data/models/chat_model.dart';
import 'package:pwa/features/conversations/data/repos/chats_repo/chats_repo_impl.dart';
import 'package:pwa/features/conversations/presentation/manager/create_chat_cubit/create_chat_cubit.dart';
import 'package:pwa/features/conversations/presentation/manager/search_for_users_cubit/search_for_user_cubit.dart';
import 'package:pwa/features/conversations/presentation/views/screens/add_user_screen.dart';
import 'package:pwa/features/conversations/presentation/views/screens/conversations_screen.dart';

abstract class AppRouter {
  static const signinScreen = '/SigninScreen';
  static const signinPersonalScreen = '/SigninPersonalScreen';
  static const conversationsScreen = '/ConversationsScreen';
  static const chatScreen = '/ChatScreen';
  static const addUserScreen = '/AddUserScreen';

  static late bool isLogged;

  static final router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      if (!isLogged) {
        if (state.fullPath == '/' ||
            state.fullPath == signinScreen ||
            state.fullPath == signinPersonalScreen) {
          return null;
        }
        return '/';
      } else {
        if (state.fullPath == '/') {
          return conversationsScreen;
        }
      }
      return null;
    },

    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: signinScreen,
        builder: (context, state) => const SigninScreen(),
      ),
      GoRoute(
        path: signinPersonalScreen,
        builder: (context, state) => const SigninPersonalScreen(),
      ),
      GoRoute(
        path: conversationsScreen,
        builder: (context, state) => const ConversationsScreen(),
      ),
      GoRoute(
        path: chatScreen,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final chat = extra['chat'] as ChatModel;
          final user = extra['user'] as UserModel;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => GetMessagesCubit(
                  getIt.get<MessagesRepoImpl>(),
                )..getChatMessages(chatId: chat.chatId),
              ),
              BlocProvider(
                create: (context) => SendMessageCubit(
                  getIt.get<MessagesRepoImpl>(),
                ),
              ),
            ],
            child: ChatScreen(
              chat: chat,
              user: user,
            ),
          );
        },
      ),
      GoRoute(
        path: addUserScreen,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CreateChatCubit(
                getIt.get<ChatsRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => SearchForUserCubit(),
            ),
          ],
          child: const AddUserScreen(),
        ),
      ),
    ],
  );
}
