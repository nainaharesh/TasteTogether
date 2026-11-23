import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/appcolors.dart';


/// White card with a thin beige border and 16px corners.
/// Used for the Settings groups and the FAQ list.
///
/// It is a Material (not a Container) on purpose: InkWell ripples are painted
/// on the nearest Material, so rows inside the card show their tap effect.
class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      clipBehavior: Clip.antiAlias, // clips the rows to the rounded corners
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: const BorderSide(color: AppColors.tint),
      ),
      child: child,
    );
  }
}