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

class LoginSection extends StatefulWidget {
  const LoginSection({super.key});

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
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
              "Login On Your Account",
              style: Styles.textStyle24,
            ),

            const SizedBox(
              height: 46,
            ),
            CustomTextFormField(
              label: 'Email',
              hint: 'you@example.com',
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
              hint: 'At least 8 characters',
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
                  if (state is AuthLoginSuccess) {
                    GoRouter.of(
                      context,
                    ).go(AppRouter.conversationsScreen);
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
                    absorbing: state is AuthLoginLoading,
                    child: CustomButton(
                      text: state is AuthLoginLoading ? 'Loading...' : 'Login',
                      icon: Icons.login,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(
                            context,
                          ).login(email: email!, password: password!);
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
              label: "Don't Have Account?   ",
              text: 'Sign In',
              onTap: () {
                GoRouter.of(context).push(AppRouter.signinScreen);
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
