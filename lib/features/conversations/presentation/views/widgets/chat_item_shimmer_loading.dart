import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pwa/core/utils/colors_theme.dart';

class ChatItemShimmerLoading extends StatelessWidget {
  const ChatItemShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: ColorsTheme.primaryLightColor),
          ),
        ),
        child: Row(
          children: [
            // Avatar shimmer
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            const SizedBox(width: 12),

            // Name + last message shimmer
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14,
                    width: 120,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 10,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Time + unread badge shimmer
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 10,
                  width: 30,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
