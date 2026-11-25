// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../viewmodels/notification_preferences_viewmodel.dart';


class NotificationPreferencesScreen
    extends GetView<NotificationPreferencesViewModel> {
  const NotificationPreferencesScreen({super.key});

  static const Color background = Color(0xFFFAF8F4);
  static const Color dark = Color(0xFF292929);
  static const Color terracotta = Color(0xFFB65C45);
  static const Color muted = Color(0xFF77716C);
  static const Color border = Color(0xFFE8D8CA);

  Widget preferenceTile({
    required String title,
    required String description,
    required RxBool setting,
  }) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 5,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: dark,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    description,
                    style: const TextStyle(
                      color: muted,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
            Transform.scale(
              scale: 0.8,
              child: Switch(
                value: setting.value,
                onChanged: (value) {
                  setting.value = value;
                },
                activeTrackColor: terracotta,
                inactiveTrackColor: const Color(0xFFC9A493),
                activeColor: Colors.white,
                inactiveThumbColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: border),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 12, 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 19,
                      color: dark,
                    ),
                  ),
                  const Text(
                    'Notification preferences',
                    style: TextStyle(
                      color: dark,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Text(
                'Choose what you want to hear about. You can change this any time.',
                style: TextStyle(
                  color: muted,
                  fontSize: 9,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Text(
                'PUSH NOTIFICATIONS',
                style: TextStyle(
                  color: dark,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 5),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: sectionCard([
                preferenceTile(
                  title: 'Likes',
                  description: 'When someone likes your review',
                  setting: controller.likes,
                ),
                const Divider(height: 1, color: border),
                preferenceTile(
                  title: 'Comments',
                  description: 'When someone comments on your review',
                  setting: controller.comments,
                ),
                const Divider(height: 1, color: border),
                preferenceTile(
                  title: 'New followers',
                  description: 'When someone starts following you',
                  setting: controller.newFollowers,
                ),
                const Divider(height: 1, color: border),
                preferenceTile(
                  title: 'Saves',
                  description: 'When someone saves your review',
                  setting: controller.saves,
                ),
              ]),
            ),

            const SizedBox(height: 18),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Text(
                'EMAIL',
                style: TextStyle(
                  color: dark,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 5),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: sectionCard([
                preferenceTile(
                  title: 'Weekly digest',
                  description: 'Top reviews from people you follow',
                  setting: controller.weeklyDigest,
                ),
                const Divider(height: 1, color: border),
                preferenceTile(
                  title: 'Tips and updates',
                  description: 'News about new features',
                  setting: controller.tipsAndUpdates,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
