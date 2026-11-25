import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'portrait.dart';

class DoctorDetailCard extends StatelessWidget {
  final String name;
  final String clinic;
  final String imageUrl;
  final double payment;
  final String currency;
  const DoctorDetailCard({super.key, required this.name, required this.clinic,
    required this.imageUrl, required this.payment, required this.currency});

  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Portrait(url: imageUrl, size: 132, radius: 10),
    const SizedBox(width: 16),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(name, maxLines: 2, overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
      const SizedBox(height: 4),
      Text(clinic, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.doctorSpecialty)),
      const SizedBox(height: 13),
      Row(children: [
        _action(Icons.chat_bubble_outline_rounded), const SizedBox(width: 8),
        _action(Icons.phone_outlined), const SizedBox(width: 8),
        _action(Icons.videocam_outlined),
      ]),
      const SizedBox(height: 18),
      Wrap(spacing: 8, children: [
        const Text('Payment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        Text((currency == 'USD' ? '\$' : '$currency ') + payment.toStringAsFixed(2), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.priceColor)),
      ]),
    ])),
  ]);

  Widget _action(IconData icon) => Container(width: 30, height: 30,
    decoration: const BoxDecoration(color: AppColors.iconCircleBg, shape: BoxShape.circle),
    child: Icon(icon, size: 16, color: AppColors.textPrimary));
}
