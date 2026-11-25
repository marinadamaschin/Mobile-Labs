import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class DoctorDetailsSection extends StatelessWidget {
  final String description;
  const DoctorDetailsSection({super.key, required this.description});
  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Details',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        Text(description,
            textAlign: TextAlign.justify,
            style: const TextStyle(
                fontSize: 13, height: 1.32, color: AppColors.textSecondary)),
      ]);
}
