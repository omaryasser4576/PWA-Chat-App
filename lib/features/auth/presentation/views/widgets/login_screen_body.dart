import 'package:flutter/material.dart';
import 'package:pwa/features/auth/presentation/views/widgets/login_section.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Image.asset(
                'assets/images/login_frame.png',
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(
                height: 55,
              ),
            ],
          ),
        ),

        const SliverFillRemaining(
          hasScrollBody: false,
          child: LoginSection(),
        ),
      ],
    );
  }
}
