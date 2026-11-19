import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../utils/aap_text_styles.dart';

/// Bottom line such as: "Already have an account?  Log in".
/// Used on all four screens.
class AuthFooterLink extends StatelessWidget {
  const AuthFooterLink({
    super.key,
    required this.question,
    required this.linkText,
     this.onTap,
  });

  final String question;
  final String linkText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(question, style: AppTextStyles.footerText),
          SizedBox(width: 6.w),
          InkWell(
            onTap: onTap,
            child: SizedBox(
              height: 44.h,
              child: Center(child: Text(linkText, style: AppTextStyles.link)),
            ),
          ),
        ],
      ),
    );
  }
}