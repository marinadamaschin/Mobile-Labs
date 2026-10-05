import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class DateSelectionSection extends StatefulWidget {
  const DateSelectionSection({super.key});

  @override
  State createState() => _DateSelectionSectionState();
}

class _DateSelectionSectionState extends State {
  int selectedIndex = 0;

  final List dates = [
    'Sun 4',
    'Mon 5',
    'Tue 6',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Date',
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 22,
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
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Row(
          children: List.generate(dates.length, (index) {
            final isSelected = selectedIndex == index;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index == dates.length - 1 ? 0 : 12.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.booking_details
                          : AppColors.serviceCardBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        dates[index],
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.4,
                          height: 1.0,
                          color: isSelected ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}