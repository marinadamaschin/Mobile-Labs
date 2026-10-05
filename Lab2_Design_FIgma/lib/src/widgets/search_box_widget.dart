import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class SearchBoxWidget extends StatelessWidget {
  const SearchBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.searchBackground,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.searchBorder,
          width: 1,
        ),
      ),
      child: const Row(
        children: [
          SizedBox(width: 16),
          SizedBox(
            width: 24,
            height: 24,
            child: Icon(
              Icons.search_rounded,
              size: 22,
              color: AppColors.searchHintText,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search something',
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.searchHintText,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          SizedBox(
            width: 24,
            height: 24,
            child: Icon(
              Icons.tune_rounded,
              size: 20,
              color: AppColors.searchHintText,
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}