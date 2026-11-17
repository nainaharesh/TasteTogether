// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:tastetogether/theme/appcolors.dart';

class FoodCategoryChip extends StatelessWidget {
  const FoodCategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        // upar neeche 4px extra sirf tap karne ki jagah barhane ke liye
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
          constraints: const BoxConstraints(minHeight: 36), // design: 36
          alignment: Alignment.center, // text ko beech mein rakhta hai
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.fieldBorder,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              height: 20 / 14,
              leadingDistribution: TextLeadingDistribution.even,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? AppColors.surface : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
