
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/notification_model.dart';

import '../../viewmodels/notification_viewmodel/notification_viewmodel.dart';

class NotificationsScreen extends GetView<NotificationsViewModel> {
  const NotificationsScreen({super.key});

  @override
  NotificationsViewModel get controller =>
      Get.put(NotificationsViewModel());


  static const Color _background = Color(0xFFFAF8F4);
  static const Color _earlierBackground = Color(0xFFF3F1EC);
  static const Color _dark = Color(0xFF2B2B2B);
  static const Color _dividerColor = Color(0xFFE8E4DD);
  static const Color _greyText = Color(0xFF8A8A8A);
  static const Color _terracotta = Color(0xFFC4573A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _dark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: _dark,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Obx(
            () => ListView(
          children: [
            _buildSectionHeading('NEW', _background),
            ...controller.newNotifications.map(_buildNotificationRow),
            _buildSectionHeading('EARLIER', _earlierBackground),
            ...controller.earlierNotifications.map(_buildNotificationRow),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeading(String title, Color bgColor) {
    return Container(
      width: double.infinity,
      color: bgColor,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: _greyText,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildNotificationRow(NotificationItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: _dividerColor, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: item.avatarColor,
            child: Text(
              item.initials,
              style: TextStyle(
                color: item.initialsColor,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: item.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(text: item.message),
                    ],
                  ),
                  style: const TextStyle(
                    color: _dark,
                    fontSize: 13.5,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      item.time,
                      style: const TextStyle(
                        color: _greyText,
                        fontSize: 11,
                      ),
                    ),
                    if (item.isUnread) ...[
                      const SizedBox(width: 6),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: _terracotta,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: item.tileColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.image_outlined,
              size: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}