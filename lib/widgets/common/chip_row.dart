// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../explore/food_category_chip.dart';


/// Horizontal scroll hone wali chips ki row (Explore, Search, Saved teeno mein)
class ChipRow extends StatelessWidget {
  const ChipRow({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
    this.padding,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  /// null ho to screen wala 16 left/right padding
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        spacing: 8.w,
        children: [
          for (var i = 0; i < labels.length; i++)
            FoodCategoryChip(
              label: labels[i],
              isSelected: i == selectedIndex,
              onTap: () => onSelected(i),
            ),
        ],
      ),
    );
  }
}
