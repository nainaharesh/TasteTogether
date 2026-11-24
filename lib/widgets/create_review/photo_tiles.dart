// ignore_for_file: deprecated_member_use
import 'dart:ui' show PathMetric;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tastetogether/theme/appcolors.dart';

/// Select ki hui photo (abhi "Preview" placeholder) + remove button
class SelectedPhotoTile extends StatelessWidget {
  const SelectedPhotoTile({super.key, required this.onRemove});

  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88.r,
      height: 88.r,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.photoPlaceholder2,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4.h,
                children: [
                  Icon(
                    Icons.image_outlined,
                    size: 22.r,
                    color: AppColors.textPrimary,
                  ),
                  Text(
                    'Preview',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -8.r,
            right: -8.r,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 28.r,
                height: 28.r,
                decoration: BoxDecoration(
                  color: AppColors.textPrimary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.background, width: 2),
                ),
                child: Icon(Icons.close, size: 14.r, color: AppColors.surface),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Dashed border wala "Add photo" dabba
class AddPhotoTile extends StatelessWidget {
  const AddPhotoTile({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: _DashedBorderPainter(radius: 14.r),
        child: SizedBox(
          width: 88.r,
          height: 88.r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4.h,
            children: [
              Icon(
                Icons.photo_camera_outlined,
                size: 24.r,
                color: AppColors.primaryDeep,
              ),
              Text(
                'Add photo',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryDeep,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({required this.radius});

  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          Radius.circular(radius),
        ),
      );
    const dash = 6.0;
    const gap = 4.0;
    for (final PathMetric m in path.computeMetrics()) {
      var d = 0.0;
      while (d < m.length) {
        canvas.drawPath(m.extractPath(d, d + dash), paint);
        d += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter old) =>
      old.radius != radius;
}
