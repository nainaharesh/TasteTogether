import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/appcolors.dart';
import '../utils/aap_text_styles.dart';

/// Label + rounded input with a left icon, as in the design.
/// Set isPassword: true to get the eye icon that shows / hides the text.
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.onFieldSubmitted,
    this.isPassword = false,
  });

  final String label;
  final String hint;
  final IconData prefixIcon;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onFieldSubmitted;
  final bool isPassword;

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
          // Shows / clears the error while the user types (after first touch).
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: AppColors.primary,
          style: AppTextStyles.input,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.hint,
            filled: true,
            fillColor: AppColors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 15.h),
            // Icon: 16 left padding, 20 icon, 12 gap (like the design)
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 12.w),
              child: Icon(
                widget.prefixIcon,
                size: 20.sp,
                color: AppColors.textSecondary,
              ),
            ),
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
            enabledBorder: _border(AppColors.fieldBorder, 1),
            focusedBorder: _border(AppColors.primary, 2),
            errorBorder: _border(AppColors.error, 1),
            focusedErrorBorder: _border(AppColors.error, 2),
          ),
        ),
      ],
    );
  }
}