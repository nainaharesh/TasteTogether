// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/appcolors.dart';
import '../utils/aap_text_styles.dart';

/// Label + rounded input with an optional left icon, as in the design.
/// Set isPassword: true to get the eye icon that shows / hides the text.
/// Set maxLines > 1 to get a multi-line box (used for the Bio field).
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.prefixIcon, // optional (Bio has no icon)
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.onFieldSubmitted,
    this.isPassword = false,
    this.maxLines = 1,
    this.maxLength,
  });

  final String label;
  final String hint;
  final IconData? prefixIcon;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onFieldSubmitted;
  final bool isPassword;
  final int maxLines;
  final int? maxLength;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // Only this field cares whether its text is hidden, so a plain bool +
  // setState is enough (no GetX variable needed).
  bool _obscure = true;

  OutlineInputBorder _border(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMultiline = widget.maxLines > 1;
    final bool hasIcon = widget.prefixIcon != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppTextStyles.label),
        SizedBox(height: 6.h),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          onFieldSubmitted: widget.onFieldSubmitted,
          obscureText: widget.isPassword && _obscure,
          // minLines = maxLines gives a fixed-height box
          minLines: widget.maxLines,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          // Shows / clears the error while the user types (after first touch).
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: AppColors.primary,
          // The Bio text is slightly smaller (15 / 22) in the design.
          style: isMultiline
              ? AppTextStyles.input.copyWith(fontSize: 15.sp, height: 22 / 15)
              : AppTextStyles.input,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: isMultiline
                ? AppTextStyles.hint.copyWith(fontSize: 15.sp)
                : AppTextStyles.hint,
            filled: true,
            fillColor: AppColors.white,
            // Hides Flutter's own "0/160" counter (the screen draws its own).
            counterText: '',
            contentPadding: isMultiline
                // extra bottom space is where the "66 / 160" counter sits
                ? EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 28.h)
                : EdgeInsets.symmetric(
                    horizontal: hasIcon ? 0 : 16.w,
                    vertical: 15.h,
                  ),
            // Icon: 16 left padding, 20 icon, 12 gap (like the design)
            prefixIcon: hasIcon
                ? Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 12.w),
                    child: Icon(
                      widget.prefixIcon,
                      size: 20.sp,
                      color: AppColors.textSecondary,
                    ),
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () => setState(() => _obscure = !_obscure),
                    icon: Icon(
                      _obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 20.sp,
                      color: AppColors.textSecondary,
                    ),
                  )
                : null,
            errorStyle: AppTextStyles.error,
            errorMaxLines: 2,
            enabledBorder: _border(AppColors.border, 1),
            focusedBorder: _border(AppColors.primary, 2),
            errorBorder: _border(AppColors.error, 1),
            focusedErrorBorder: _border(AppColors.error, 2),
          ),
        ),
      ],
    );
  }
}