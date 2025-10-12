import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwa/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pwa/features/conversations/presentation/manager/get_chats_cubit/get_chats_cubit.dart';
import 'package:pwa/features/conversations/presentation/manager/get_users_cubit/get_users_cubit.dart';
import 'package:pwa/features/conversations/presentation/views/widgets/add_user_floating_button.dart';
import 'package:pwa/features/conversations/presentation/views/widgets/conversations_screen_body.dart';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  @override
  void initState() {
    super.initState();
    getUsersAndChats();
  }

  void getUsersAndChats() async {
    await BlocProvider.of<GetUsersCubit>(context).getUsers();
    BlocProvider.of<GetChatsCubit>(context).getChats();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthAlreadyLoggedIn) {
          getUsersAndChats();
        }
      },
      child: const Scaffold(
        body: ConversationsScreenBody(),
        floatingActionButton: AddUserFloatingButton(),
      ),
    );
  }
}
