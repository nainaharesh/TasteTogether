// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/viewmodels/user_activity/setting_controller.dart';
import 'package:tastetogether/views/user_activity/notification_preferences.dart';
import 'package:tastetogether/views/user_activity/edit_profile_screen.dart';
import 'package:tastetogether/views/user_activity/help_support_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tastetogether/widgets/common/custom_button.dart';
import 'package:tastetogether/widgets/common/user_avatar.dart';
import 'package:tastetogether/widgets/components/app_card.dart';
import 'package:tastetogether/widgets/components/app_page_layout.dart';
import 'package:tastetogether/widgets/components/section_label.dart';



class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  SettingsController get controller => Get.put(SettingsController());

  Widget divider() => Divider(height: 1, thickness: 1, color: AppColors.border);

  @override
  Widget build(BuildContext context) {
    return AppPageLayout(
      title: 'Settings',
      children: [
        SizedBox(height: 8.h),
        buildProfileCard(),
        SizedBox(height: 20.h),

        const SectionLabel('Account'),
        AppCard(
          child: Column(
            children: [
              SettingsRow(
                icon: Icons.person_outline,
                title: 'Edit profile',
                onTap: () => Get.to(() => EditProfileScreen()),
              ),
              divider(),
              SettingsRow(
                icon: Icons.notifications_none,
                title: 'Notification preferences',
                onTap: () => Get.to(() => NotificationPreferencesScreen()),
              ),
              divider(),
              SettingsRow(
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
              SettingsRow(
                icon: Icons.help_outline,
                title: 'Help and support',
                onTap: () => Get.to(() => HelpSupportScreen()),
              ),
              divider(),
              SettingsRow(
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
  Widget buildProfileCard() {
    return AppCard(
      child: InkWell(
        onTap: () => Get.to(() => EditProfileScreen()),
        child: SizedBox(
          height: 80.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Obx(() {
              final name = controller.userName.value;
              final initials = UserAvatar.initialsOf(name);
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
                        ? Icon(
                            Icons.person_outline,
                            size: 26.sp,
                            color: AppColors.surface,
                          )
                        : Text(
                            initials,
                            style: GoogleFonts.dmSans(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.surface,
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
                          style: GoogleFonts.dmSans(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ).copyWith(fontWeight: FontWeight.w700),
                        ),
                        if (controller.userEmail.value.isNotEmpty) ...[
                          SizedBox(height: 2.h),
                          Text(
                            controller.userEmail.value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.dmSans(
                              fontSize: 13.sp,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 20.sp,
                    color: AppColors.textMuted,
                  ),
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
class SettingsRow extends StatelessWidget {
  const SettingsRow({super.key, 
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
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, size: 20.sp, color: AppColors.textPrimary),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.dmSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              if (trailingText != null) ...[
                Text(
                  trailingText!,
                  style: GoogleFonts.dmSans(
                    fontSize: 13.sp,
                    color: AppColors.textMuted,
                  ),
                ),
                SizedBox(width: 8.w),
              ],
              Icon(
                Icons.chevron_right,
                size: 20.sp,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
