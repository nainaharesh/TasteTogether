import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/aap_text_styles.dart';


/// Small grey heading above a card: "ACCOUNT", "SUPPORT", "FREQUENTLY ASKED".
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28.h,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text.toUpperCase(), style: AppTextStyles.sectionLabel),
      ),
    );
  }
}