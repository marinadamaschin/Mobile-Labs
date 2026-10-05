import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class HealthServicesSection extends StatelessWidget {
  const HealthServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Health Services',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'See All',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.coralGreen,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _HealthServiceItem(
              title: 'Tooth',
              iconPath: 'assets/images/tooth.png',
            ),
            _HealthServiceItem(
              title: 'Eye',
              iconPath: 'assets/images/eye.png',
            ),
            _HealthServiceItem(
              title: 'Lungs',
              iconPath: 'assets/images/lungs.png',
            ),
            _HealthServiceItem(
              title: 'Ear',
              iconPath: 'assets/images/ear.png',
            ),
          ],
        ),
      ],
    );
  }
}


class _HealthServiceItem extends StatelessWidget {
  final String title;
  final String iconPath;

  const _HealthServiceItem({
    required this.title,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.serviceCardBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              width: 32,
              height: 32,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.medical_services_outlined,
                  size: 28,
                  color: AppColors.textSecondary,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}