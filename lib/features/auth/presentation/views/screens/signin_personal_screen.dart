import 'package:flutter/material.dart';
import 'package:pwa/features/auth/presentation/views/widgets/signin_personal_screen_body.dart';

class SigninPersonalScreen extends StatelessWidget {
  const SigninPersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SigninPersonalScreenBody(),
    );
  }
}
