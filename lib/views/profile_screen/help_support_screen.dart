// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tastetogether/models/support/support_models.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/support_controller.dart';
import 'package:tastetogether/widgets/components/app_card.dart';
import 'package:tastetogether/widgets/components/app_page_layout.dart';
import 'package:tastetogether/widgets/components/section_label.dart';
import 'package:tastetogether/widgets/custom_button.dart';


class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  SupportController get controller => Get.put(SupportController());
  @override
  Widget build(BuildContext context) {
    return AppPageLayout(
      title: 'Help and support',
      children: [
        SizedBox(height: 8.h),
        buildSearchField(),
        SizedBox(height: 20.h),
        const SectionLabel('Frequently asked'),
        buildFaqList(),
        SizedBox(height: 24.h),
        const Spacer(),
        buildContactBox(),
      ],
    );
  }

  Widget buildSearchField() {
    OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(color: color, width: width),
    );

    return TextField(
      controller: controller.searchController,
      onChanged: controller.onSearchChanged,
      textInputAction: TextInputAction.search,
      cursorColor: AppColors.primary,
      style: GoogleFonts.dmSans(
        fontSize: 16.sp,
        color: AppColors.textPrimary,
      ).copyWith(fontSize: 15.sp),
      decoration: InputDecoration(
        hintText: 'Search help articles',
        hintStyle: GoogleFonts.dmSans(
          fontSize: 16.sp,
          color: AppColors.textMuted,
        ).copyWith(fontSize: 15.sp),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 14.w, right: 10.w),
          child: Icon(Icons.search, size: 20.sp, color: AppColors.textMuted),
        ),
        prefixIconConstraints: const BoxConstraints(),
        enabledBorder: border(AppColors.border, 1),
        focusedBorder: border(AppColors.primary, 2),
      ),
    );
  }

  /// The expandable question list. Obx rebuilds it when the search text or the
  /// open question changes.
  Widget buildFaqList() {
    return Obx(() {
      final faqs = controller.filteredFaqs;
      final openId = controller.openFaqId.value;

      if (faqs.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Text(
            'No articles found.',
            style: GoogleFonts.dmSans(
              fontSize: 13.sp,
              color: AppColors.textMuted,
            ),
          ),
        );
      }

      return AppCard(
        child: Column(
          children: [
            for (int i = 0; i < faqs.length; i++) ...[
              buildFaqItem(faqs[i], isOpen: faqs[i].id == openId),
              if (i != faqs.length - 1)
                Divider(height: 1, thickness: 1, color: AppColors.border),
            ],
          ],
        ),
      );
    });
  }

  Widget buildFaqItem(FaqModel faq, {required bool isOpen}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => controller.toggleFaq(faq.id),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 56.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      faq.question,
                      style: GoogleFonts.dmSans(
                        fontSize: 15.sp,
                        height: 21 / 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Icon(
                    isOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 24.sp,
                    color: AppColors.textMuted,
                  ),
                ],
              ),
            ),
          ),
        ),
        // Only the open question shows its answer.
        if (isOpen)
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
            child: Text(
              faq.answer,
              style: GoogleFonts.dmSans(
                fontSize: 14.sp,
                height: 21 / 14,
                color: AppColors.textMuted,
              ),
            ),
          ),
      ],
    );
  }

  Widget buildContactBox() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Still need help?',
            style: GoogleFonts.dmSans(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 2.h),
          // TODO(backend/support): this promise is copied from the design.
          // Make sure it matches the real support response time.
          Text(
            'Our team replies within one working day.',
            style: GoogleFonts.dmSans(
              fontSize: 14.sp,
              height: 21 / 14,
              color: AppColors.textMuted,
            ).copyWith(color: AppColors.textPrimary, height: 20 / 14),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Contact us',
                  icon: Icons.mail_outline,
                  height: 48,
                  fontSize: 15,
                  onPressed: controller.contactUs,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: CustomButton(
                  text: 'Report a problem',
                  isOutlined: true,
                  height: 48,
                  fontSize: 15,
                  onPressed: controller.reportProblem,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
