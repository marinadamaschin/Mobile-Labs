import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class BookAppointmentButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  const BookAppointmentButton({super.key, required this.onPressed, required this.label});
  @override
  Widget build(BuildContext context) => SizedBox(width: double.infinity, height: 56,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.bookingDetails,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Text(label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
    ));
}
