import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwa/core/utils/colors_theme.dart';
import 'package:pwa/features/conversations/presentation/manager/get_chats_cubit/get_chats_cubit.dart';
import 'package:pwa/features/conversations/presentation/manager/get_users_cubit/get_users_cubit.dart';

class SearchForUserTextField extends StatefulWidget {
  const SearchForUserTextField({
    super.key,
  });

  @override
  State<SearchForUserTextField> createState() => _SearchForUserTextFieldState();
}

class _SearchForUserTextFieldState extends State<SearchForUserTextField> {
  Timer? debounce;

  void onSearch(String username) {
    if (debounce?.isActive ?? false) {
      debounce!.cancel();
    }
    debounce = Timer(
      const Duration(milliseconds: 500),
      () {
        context.read<GetUsersCubit>().searchForUsersByUsername(
          username: username,
        );
      },
    );
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onSearch,
      decoration: InputDecoration(
        hintText: 'Search for user...',
        filled: true,
        fillColor: ColorsTheme.samiWhite,
        border: outlineBorder(),
        enabledBorder: outlineBorder(),
        focusedBorder: outlineBorder(),
      ),
    );
  }

  OutlineInputBorder outlineBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide(
        color: ColorsTheme.primaryLightColor,
      ),
    );
  }
}
