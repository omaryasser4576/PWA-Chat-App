import 'package:flutter/material.dart';
import 'package:pwa/features/auth/presentation/views/widgets/signin_section.dart';

class SigninScreenBody extends StatelessWidget {
  const SigninScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Image.asset(
                'assets/images/signin_frame.png',
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(
                height: 45,
              ),
            ],
          ),
        ),

        const SliverFillRemaining(
          hasScrollBody: false,
          child: SigninSection(),
        ),
      ],
    );
  }
}
