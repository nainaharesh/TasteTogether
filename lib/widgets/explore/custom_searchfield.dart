// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:tastetogether/theme/appcolors.dart';

class SearchTextField extends StatelessWidget {
final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const SearchTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      cursorColor: AppColors.primary,
      style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 15, color: AppColors.textMuted),

        prefixIcon: prefixIcon == null
            ? null
            : Padding(
          padding: const EdgeInsets.only(left: 14, right: 10),
          child: prefixIcon,
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        // filter button right se 4px
        suffixIcon: suffixIcon == null
            ? null
            : Padding(
          padding: const EdgeInsets.only(right: 4),
          child: suffixIcon,
        ),
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: prefixIcon == null
            ? const EdgeInsets.symmetric(horizontal: 14, vertical: 14)
            : const EdgeInsets.symmetric(vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.fieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}