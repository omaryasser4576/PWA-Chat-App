import 'package:flutter/material.dart';
import 'package:pwa/features/auth/presentation/views/widgets/title_item.dart';

class TitlesWidgets extends StatelessWidget {
  const TitlesWidgets({super.key, this.selectedName = 'Login'});

  final String? selectedName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleItem(
          title: 'Login',
          icon: Icons.login,
          selected: selectedName == 'Login' ? true : false,
        ),
        TitleItem(
          title: 'Personal',
          icon: Icons.person_outline,
          selected: selectedName == 'Personal' ? true : false,
        ),
      ],
    );
  }
}
