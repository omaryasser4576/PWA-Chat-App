import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pwa/core/utils/app_router.dart';
import 'package:pwa/core/utils/styles.dart';
import 'package:pwa/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pwa/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:pwa/features/auth/presentation/views/widgets/custom_labeled_text_button.dart';
import 'package:pwa/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:pwa/features/auth/presentation/views/widgets/password_text_form_field.dart';
import 'package:pwa/features/auth/presentation/views/widgets/titles_widgets.dart';

class SigninSection extends StatefulWidget {
  const SigninSection({super.key});

  @override
  State<SigninSection> createState() => _SigninSectionState();
}

class _SigninSectionState extends State<SigninSection> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "SignIn For Account",
              style: Styles.textStyle24,
            ),
            const SizedBox(
              height: 20,
            ),
            const TitlesWidgets(
              selectedName: 'Login',
            ),

            const SizedBox(
              height: 36,
            ),
            CustomTextFormField(
              label: 'Email',
              hint: 'Enter your email...',
              icon: Icons.email_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'The email is required.';
                } else if (!value.contains('@gmail.com')) {
                  return "Email must contain '@gmail.com'";
                }
                return null;
              },
              onChanged: (value) {
                email = value;
              },
            ),

            const SizedBox(
              height: 20,
            ),
            PasswordTextFormField(
              hint: 'Enter your password...',
              onChanged: (value) {
                password = value;
              },
            ),

            const SizedBox(
              height: 36,
            ),

            Align(
              alignment: Alignment.center,
              child: BlocConsumer<AuthCubit, AuthStates>(
                listener: (context, state) {
                  if (state is AuthSignInSuccess) {
                    GoRouter.of(context).push(AppRouter.signinPersonalScreen);
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return AbsorbPointer(
                    absorbing: state is AuthSignInLoading,
                    child: CustomButton(
                      text: state is AuthSignInLoading
                          ? 'Loading...'
                          : 'Next Step',
                      icon: Icons.fast_forward_outlined,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(
                            context,
                          ).signIn(email: email!, password: password!);
                        } else {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                    ),
                  );
                },
              ),
            ),

            const Expanded(
              child: SizedBox(
                height: 30,
              ),
            ),

            // Don't have an account.
            CustomLabeledTextButton(
              label: "You Have Account?   ",
              text: 'LogIn',
              onTap: () {
                GoRouter.of(context).pop();
              },
            ),

            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
