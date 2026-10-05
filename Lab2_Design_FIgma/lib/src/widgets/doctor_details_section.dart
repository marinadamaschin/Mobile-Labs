import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class DoctorDetailsSection extends StatelessWidget {
  const DoctorDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Details',
          style: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 13,
            fontWeight: FontWeight.w400,
            height: 1.32,
            letterSpacing: 0.0,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}