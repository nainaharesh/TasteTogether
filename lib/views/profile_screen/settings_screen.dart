import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/app_routes.dart';
import '../../theme/appcolors.dart';
import '../../utils/aap_text_styles.dart';

import '../../utils/helpers.dart';
import '../../viewmodels/settings/setting_controller.dart';

import '../../widgets/components/app_card.dart';
import '../../widgets/components/app_page_layout.dart';
import '../../widgets/components/section_label.dart';
import '../../widgets/custom_button.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  SettingsController get controller => Get.put(SettingsController());

  Widget _divider() => Divider(height: 1, thickness: 1, color: AppColors.tint);

  @override
  Widget build(BuildContext context) {
    return AppPageLayout(
      title: 'Settings',
      children: [
        SizedBox(height: 8.h),
        _buildProfileCard(),
        SizedBox(height: 20.h),

        const SectionLabel('Account'),
        AppCard(
          child: Column(
            children: [
              _SettingsRow(
                icon: Icons.person_outline,
                title: 'Edit profile',
                onTap: () => Get.toNamed(AppRoutes.editProfile),
              ),
              _divider(),
              _SettingsRow(
                icon: Icons.notifications_none,
                title: 'Notification preferences',
                // TODO: this screen is not part of this task. Add its route later.
                onTap: null,
              ),
              _divider(),
              _SettingsRow(
                icon: Icons.shield_outlined,
                title: 'Privacy settings',
                // TODO: this screen is not part of this task. Add its route later.
                onTap: null,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        const SectionLabel('Support'),
        AppCard(
          child: Column(
            children: [
              _SettingsRow(
                icon: Icons.help_outline,
                title: 'Help and support',
                onTap: () => Get.toNamed(AppRoutes.help),
              ),
              _divider(),
              _SettingsRow(
                icon: Icons.info_outline,
                title: 'About TasteTogether',
                trailingText: SettingsController.appVersion,
                // TODO: no "About" screen exists in this task.
                onTap: null,
              ),
            ],
          ),
        ),

        SizedBox(height: 24.h),
        const Spacer(),
        CustomButton(
          text: 'Log out',
          icon: Icons.logout,
          isOutlined: true,
          onPressed: controller.logout,
        ),
      ],
    );
  }

  /// Top card: avatar, name, email. Tap = open Edit Profile.
  Widget _buildProfileCard() {
    return AppCard(
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.editProfile),
        child: SizedBox(
          height: 80.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Obx(() {
              final name = controller.userName.value;
              final initials = getInitials(name);
              return Row(
                children: [
                  Container(
                    width: 52.w,
                    height: 52.w,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: initials.isEmpty
                        ? Icon(Icons.person_outline, size: 26.sp, color: AppColors.white)
                        : Text(
                      initials,
                      style: GoogleFonts.dmSans(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name.isEmpty ? 'Your profile' : name,
                          style: AppTextStyles.rowTitle.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (controller.userEmail.value.isNotEmpty) ...[
                          SizedBox(height: 2.h),
                          Text(
                            controller.userEmail.value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.meta,
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, size: 20.sp, color: AppColors.textSecondary),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

/// One row inside a settings card: icon box, title, optional grey text, chevron.
/// Private (_) because only this file uses it.
class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailingText,
  });

  final IconData icon;
  final String title;
  final String? trailingText;
  final VoidCallback? onTap; // null = nothing happens yet

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 56.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: AppColors.tint,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, size: 20.sp, color: AppColors.textPrimary),
              ),
              SizedBox(width: 12.w),
              Expanded(child: Text(title, style: AppTextStyles.rowTitle)),
              if (trailingText != null) ...[
                Text(trailingText!, style: AppTextStyles.meta),
                SizedBox(width: 8.w),
              ],
              Icon(Icons.chevron_right, size: 20.sp, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}