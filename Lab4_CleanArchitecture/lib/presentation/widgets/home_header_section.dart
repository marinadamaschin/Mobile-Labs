import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/medical_entities.dart';
import 'portrait.dart';

class HomeHeaderSection extends StatelessWidget {
  final UserProfile user;
  final bool hasUnread;
  const HomeHeaderSection(
      {super.key, required this.user, required this.hasUnread});
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Portrait(url: user.avatarUrl, size: 44),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(user.greeting,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary)),
                const SizedBox(height: 2),
                Text(user.subtitle,
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.textSecondary)),
              ])),
          Stack(clipBehavior: Clip.none, children: [
            const Icon(Icons.notifications_none_rounded,
                color: AppColors.textPrimary, size: 26),
            if (hasUnread)
              const Positioned(
                  top: 1,
                  right: 3,
                  child: CircleAvatar(
                      radius: 4, backgroundColor: AppColors.badgeRed)),
          ]),
          const SizedBox(width: 14),
        ],
      );
}
