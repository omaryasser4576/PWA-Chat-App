import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pwa/core/utils/app_router.dart';
import 'package:pwa/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pwa/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:pwa/features/auth/presentation/views/widgets/custom_labeled_text_button.dart';
import 'package:pwa/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:pwa/features/auth/presentation/views/widgets/titles_widgets.dart';

class PersonalSection extends StatefulWidget {
  const PersonalSection({super.key, this.fileImage});
  final File? fileImage;

  @override
  State<PersonalSection> createState() => _PersonalSectionState();
}

class _PersonalSectionState extends State<PersonalSection> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? fullName;
  String? phoneNumber;

  @override
  void dispose() {
    super.dispose();
    deleteUser();
  }

  void deleteUser() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      currentUser.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            const TitlesWidgets(
              selectedName: 'Personal',
            ),

            const SizedBox(height: 36),

            CustomTextFormField(
              label: 'Full Name',
              hint: 'Enter full name...',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'The name is required.';
                }
                return null;
              },
              onChanged: (value) {
                fullName = value;
              },
            ),

            const SizedBox(height: 20),

            CustomTextFormField(
              label: 'Username',
              hint: '@username',
              iconImage: 'assets/icons/icon _phone.png',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'The username is required.';
                }
                return null;
              },
              onChanged: (value) {
                phoneNumber = value;
              },
            ),
            const SizedBox(height: 36),

            BlocConsumer<AuthCubit, AuthStates>(
              listener: (context, state) {
                if (state is AuthCompleteProfileSuccess) {
                  GoRouter.of(context).push(AppRouter.conversationsScreen);
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
                  absorbing: state is AuthCompleteProfileLoading,
                  child: CustomButton(
                    text: state is AuthCompleteProfileLoading
                        ? 'Loading...'
                        : 'SignIn',
                    icon: Icons.login,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthCubit>(
                          context,
                        ).completeProfile(
                          fullName: fullName!,
                          username: phoneNumber!,
                          userImage: widget.fileImage?.path,
                        );
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

            const Expanded(child: SizedBox(height: 36)),

            CustomLabeledTextButton(
              label: '',
              text: 'Back',
              onTap: () {
                deleteUser();
                GoRouter.of(context).pop();
              },
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
