import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../models/support/support_models.dart';
import '../../theme/appcolors.dart';
import '../../utils/aap_text_styles.dart';


import '../../viewmodels/support/support_controller.dart';
import '../../widgets/components/app_card.dart';
import '../../widgets/components/app_page_layout.dart';
import '../../widgets/components/section_label.dart';
import '../../widgets/custom_button.dart';


class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  SupportController get controller => Get.put(SupportController());
  @override
  Widget build(BuildContext context) {
    return AppPageLayout(
      title: 'Help and support',
      children: [
        SizedBox(height: 8.h),
        _buildSearchField(),
        SizedBox(height: 20.h),
        const SectionLabel('Frequently asked'),
        _buildFaqList(),
        SizedBox(height: 24.h),
        const Spacer(),
        _buildContactBox(),
      ],
    );
  }

  Widget _buildSearchField() {
    OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: BorderSide(color: color, width: width),
    );

    return TextField(
      controller: controller.searchController,
      onChanged: controller.onSearchChanged,
      textInputAction: TextInputAction.search,
      cursorColor: AppColors.primary,
      style: AppTextStyles.input.copyWith(fontSize: 15.sp),
      decoration: InputDecoration(
        hintText: 'Search help articles',
        hintStyle: AppTextStyles.hint.copyWith(fontSize: 15.sp),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 14.w, right: 10.w),
          child: Icon(Icons.search, size: 20.sp, color: AppColors.textSecondary),
        ),
        prefixIconConstraints: const BoxConstraints(),
        enabledBorder: border(AppColors.border, 1),
        focusedBorder: border(AppColors.primary, 2),
      ),
    );
  }

  /// The expandable question list. Obx rebuilds it when the search text or the
  /// open question changes.
  Widget _buildFaqList() {
    return Obx(() {
      final faqs = controller.filteredFaqs;
      final openId = controller.openFaqId.value;

      if (faqs.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Text('No articles found.', style: AppTextStyles.meta),
        );
      }

      return AppCard(
        child: Column(
          children: [
            for (int i = 0; i < faqs.length; i++) ...[
              _buildFaqItem(faqs[i], isOpen: faqs[i].id == openId),
              if (i != faqs.length - 1)
                Divider(height: 1, thickness: 1, color: AppColors.tint),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildFaqItem(FaqModel faq, {required bool isOpen}) {
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
                    child: Text(faq.question, style: AppTextStyles.faqQuestion),
                  ),
                  SizedBox(width: 12.w),
                  Icon(
                    isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: 24.sp,
                    color: AppColors.textSecondary,
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
            child: Text(faq.answer, style: AppTextStyles.faqAnswer),
          ),
      ],
    );
  }

  Widget _buildContactBox() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.tint,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Still need help?',
            style: AppTextStyles.rowTitle.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 2.h),
          // TODO(backend/support): this promise is copied from the design.
          // Make sure it matches the real support response time.
          Text(
            'Our team replies within one working day.',
            style: AppTextStyles.faqAnswer.copyWith(
              color: AppColors.textPrimary,
              height: 20 / 14,
            ),
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