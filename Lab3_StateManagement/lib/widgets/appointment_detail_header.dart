import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class AppointmentDetailHeader extends StatelessWidget {
  final String title;
  const AppointmentDetailHeader({super.key, required this.title});
  @override
  Widget build(BuildContext context) => SizedBox(height: 40, child: Stack(alignment: Alignment.center, children: [
    Align(alignment: Alignment.centerLeft,
      child: IconButton(onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary))),
    Text(title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.bookingDetails)),
  ]));
}
