// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tastetogether/theme/appcolors.dart';
import 'package:tastetogether/widgets/common/preference_tile.dart';
import 'package:tastetogether/widgets/components/app_card.dart';
import 'package:tastetogether/widgets/components/app_page_layout.dart';
import 'package:tastetogether/widgets/components/section_label.dart';


/// Notification preferences (Settings se khulti hai).
///
/// Sirf UI: koi API / controller nahi. 6 switches ki value isi screen ki
/// State mein hai (setState). Screen band karke dobara khulne par design ke
/// default par wapas aa jati hain.
class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  State<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends State<NotificationPreferencesScreen> {
  // Push (default design ke mutabiq: Saves band)
  bool likes = true;
  bool comments = true;
  bool newFollowers = true;
  bool saves = false;

  // Email (default: Tips band)
  bool weeklyDigest = true;
  bool tipsAndUpdates = false;

  Widget divider() => const Divider(height: 1, color: AppColors.border);

  @override
  Widget build(BuildContext context) {
    return AppPageLayout(
      title: 'Notification preferences',
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Text(
            'Choose what you want to hear about. You can change this any time.',
            style: GoogleFonts.dmSans(
              fontSize: 15.sp,
              height: 22 / 15,
              color: AppColors.textMuted,
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: const SectionLabel('Push notifications'),
        ),
        AppCard(
          child: Column(
            children: [
              PreferenceTile(
                title: 'Likes',
                description: 'When someone likes your review',
                value: likes,
                onChanged: (v) => setState(() => likes = v),
              ),
              divider(),
              PreferenceTile(
                title: 'Comments',
                description: 'When someone comments on your review',
                value: comments,
                onChanged: (v) => setState(() => comments = v),
              ),
              divider(),
              PreferenceTile(
                title: 'New followers',
                description: 'When someone starts following you',
                value: newFollowers,
                onChanged: (v) => setState(() => newFollowers = v),
              ),
              divider(),
              PreferenceTile(
                title: 'Saves',
                description: 'When someone saves your review',
                value: saves,
                onChanged: (v) => setState(() => saves = v),
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: const SectionLabel('Email'),
        ),
        AppCard(
          child: Column(
            children: [
              PreferenceTile(
                title: 'Weekly digest',
                description: 'Top reviews from people you follow',
                value: weeklyDigest,
                onChanged: (v) => setState(() => weeklyDigest = v),
              ),
              divider(),
              PreferenceTile(
                title: 'Tips and updates',
                description: 'News about new features',
                value: tipsAndUpdates,
                onChanged: (v) => setState(() => tipsAndUpdates = v),
              ),
            ],
          ),
        ),
      ],
    );
  }
}