import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class DoctorDetailCard extends StatelessWidget {
  const DoctorDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 132,
          height: 132,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage('assets/images/doctor3.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Dr.Upul',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  _buildActionIcon(Icons.chat_bubble_outline_rounded),
                  const SizedBox(width: 6),
                  _buildActionIcon(Icons.phone_outlined),
                  const SizedBox(width: 6),
                  _buildActionIcon(Icons.videocam_outlined),
                ],
              ),
              const SizedBox(height: 4),

              const Text(
                'Denteeth',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.doctorSpecialty,
                ),
              ),

              const SizedBox(height: 32),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '\$120.00',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.priceColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionIcon(IconData icon) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        color: AppColors.iconCircleBg,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 16,
        color: AppColors.textPrimary,
      ),
    );
  }
}