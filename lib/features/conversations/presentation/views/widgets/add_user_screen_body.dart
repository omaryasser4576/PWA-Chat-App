import 'package:flutter/material.dart';
import 'package:pwa/features/conversations/presentation/views/widgets/custom_add_user_app_bar.dart';
import 'package:pwa/features/conversations/presentation/views/widgets/users_list_view.dart';

class AddUserScreenBody extends StatelessWidget {
  const AddUserScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomAddUserAppBar(),
        Expanded(
          child: UsersListView(),
        ),
      ],
    );
  }
}
