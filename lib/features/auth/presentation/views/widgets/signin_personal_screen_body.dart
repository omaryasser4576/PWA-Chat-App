import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pwa/features/auth/presentation/views/widgets/add_image_widget.dart';
import 'package:pwa/features/auth/presentation/views/widgets/personal_section.dart';

class SigninPersonalScreenBody extends StatefulWidget {
  const SigninPersonalScreenBody({super.key});

  @override
  State<SigninPersonalScreenBody> createState() =>
      _SigninPersonalScreenBodyState();
}

class _SigninPersonalScreenBodyState extends State<SigninPersonalScreenBody> {
  File? fileImage;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    'assets/images/personal_details_frame.png',
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Positioned(
                    bottom: -60,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: AddImageWidget(
                        selectedImage: (image) {
                          setState(() {
                            fileImage = image;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 116,
              ),
            ],
          ),
        ),

        SliverFillRemaining(
          hasScrollBody: false,
          child: PersonalSection(
            fileImage: fileImage,
          ),
        ),
      ],
    );
  }
}
