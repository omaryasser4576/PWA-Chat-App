import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwa/features/conversations/presentation/manager/search_for_users_cubit/search_for_user_cubit.dart';
import 'package:pwa/features/conversations/presentation/views/widgets/add_user_item.dart';
import 'package:pwa/features/conversations/presentation/views/widgets/add_user_shimmer_item.dart';

class UsersListView extends StatelessWidget {
  const UsersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchForUserCubit, SearchForUserState>(
      builder: (context, state) {
        if (state is SearchForUserSuccess) {
          final users = state.users;
          if (users.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: users.length,
              itemBuilder: (context, index) => AddUserItem(user: users[index]),
            );
          } else {
            return const Center(
              child: Text('There are not users'),
            );
          }
        } else if (state is SearchForUserLoading) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 3,
            itemBuilder: (context, index) => const AddUserItemShimmer(),
          );
        } else if (state is SearchForUserFailure) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return const Center(
            child: Text('Start searching for users...'),
          );
        }
      },
    );
  }
}
