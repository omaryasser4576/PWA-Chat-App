import 'package:flutter/material.dart';
import 'package:pwa/features/auth/data/models/user_model.dart';

class CustomUserImage extends StatelessWidget {
  const CustomUserImage({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: user.userImage == null
            ? Image.asset(
                'assets/images/test.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : Image.network(
                user.userImage!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
