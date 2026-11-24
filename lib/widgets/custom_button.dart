import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/appcolors.dart';
import '../utils/aap_text_styles.dart';

/// Full-width terracotta button (52 high, radius 14).
/// While isLoading is true it shows a spinner and ignores taps.
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
     this.onPressed,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        // null onPressed = disabled button
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          // keep the same look while loading (disabled)
          disabledBackgroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: isLoading
            ? SizedBox(
          width: 22.w,
          height: 22.w,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: AppColors.white,
          ),
        )
            : Text(text, style: AppTextStyles.button),
      ),
    );
  }
}