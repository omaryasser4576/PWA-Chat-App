import 'package:flutter/material.dart';
import 'package:pwa/features/conversations/presentation/views/widgets/add_user_screen_body.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AddUserScreenBody(),
    );
  }
}
