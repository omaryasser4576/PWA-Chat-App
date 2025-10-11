import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwa/features/conversations/presentation/manager/get_users_cubit/get_users_cubit.dart';
import 'package:pwa/features/conversations/presentation/views/widgets/add_user_item.dart';
import 'package:pwa/features/conversations/presentation/views/widgets/add_user_shimmer_item.dart';

class UsersListView extends StatelessWidget {
  const UsersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUsersCubit, GetUsersState>(
      builder: (context, state) {
        if (state is GetUsersSuccess) {
          final users = state.users;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: users.length,
            itemBuilder: (context, index) => AddUserItem(user: users[index]),
          );
        } else if (state is GetUsersLoading) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 3,
            itemBuilder: (context, index) => const AddUserItemShimmer(),
          );
        } else if( state is GetUsersFailure) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return const Center(
            child: Text('There are not users'),
          );
        }
      },
    );
  }
}
