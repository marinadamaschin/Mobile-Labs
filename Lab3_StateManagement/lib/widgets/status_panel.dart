import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class StatusPanel extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final VoidCallback? onRetry;
  final String actionLabel;
  const StatusPanel({super.key, required this.icon, required this.title, required this.message, this.onRetry, this.actionLabel = 'Try again'});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 28),
    child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: AppColors.bookingDetails, size: 38),
      const SizedBox(height: 12),
      Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
      const SizedBox(height: 8),
      Text(message, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textSecondary)),
      if (onRetry != null) ...[
        const SizedBox(height: 16),
        FilledButton(onPressed: onRetry, child: Text(actionLabel)),
      ],
    ])),
  );
}
