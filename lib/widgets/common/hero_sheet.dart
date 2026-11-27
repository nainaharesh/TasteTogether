// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';

import '../home_feed/photo_placeholder.dart';


/// Details screens ka common layout: upar 280 ki photo, uske upar back/save
/// buttons, aur neeche rounded sheet (24 radius) jo photo par 24 chadhti hai.
class HeroSheet extends StatelessWidget {
  const HeroSheet({
    super.key,
    required this.photoLabel,
    required this.photoPrefix,
    required this.isSaved,
    required this.onBack,
    required this.onSave,
    required this.child,
    this.imageUrl,
  });

  final String photoLabel;
  final String photoPrefix; // 'Cover photo' / 'Dish photo'
  final String? imageUrl;
  final bool isSaved;
  final VoidCallback onBack;
  final VoidCallback onSave;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return Stack(
      children: [
        // photo
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 280.h,
          child: PhotoPlaceholder(
            label: photoLabel,
            labelPrefix: photoPrefix,
            imageUrl: imageUrl,
            placeholderColor: AppColors.fieldBorder, // #D2B7A3
            iconSize: 32,
            spacing: 6,
            fontSize: 12,
          ),
        ),

        // sheet
        Padding(
          padding: EdgeInsets.only(top: 256.h),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: child,
          ),
        ),

        // back + save
        Positioned(
          top: topInset + 8.h,
          left: 16.w,
          child: CircleButton(icon: Icons.arrow_back_rounded, onTap: onBack),
        ),
        Positioned(
          top: topInset + 8.h,
          right: 16.w,
          child: CircleButton(
            icon: isSaved ? Icons.bookmark : Icons.bookmark_border_rounded,
            onTap: onSave,
          ),
        ),
      ],
    );
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(side: BorderSide(color: AppColors.border)),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 44.r,
          height: 44.r,
          child: Icon(icon, size: 22.r, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
