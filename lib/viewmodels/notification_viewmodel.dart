
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationsViewModel extends GetxController {

  static const Color terracotta = Color(0xFFC4573A);
  static const Color dark = Color(0xFF2B2B2B);
  static const Color lightAvatar = Color(0xFFF1E3D3);
  static const Color tileLight = Color(0xFFEBD8C7);
  static const Color tileDark = Color(0xFFD9B8A0);

  final RxList<NotificationItem> newNotifications =
      <NotificationItem>[].obs;

  final RxList<NotificationItem> earlierNotifications =
      <NotificationItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {

    newNotifications.assignAll([
      const NotificationItem(
        initials: 'AR',
        username: 'amina.eats',
        message: ' liked your review of Charred Lamb Kofta.',
        time: '2m ago',
        avatarColor: terracotta,
        initialsColor: Colors.white,
        tileColor: tileLight,
        isUnread: true,
      ),
      const NotificationItem(
        initials: 'DO',
        username: 'danny_dines',
        message: ' commented: "Need to try this place this weekend!"',
        time: '18m ago',
        avatarColor: dark,
        initialsColor: Colors.white,
        tileColor: tileLight,
        isUnread: true,
      ),
      const NotificationItem(
        initials: 'SM',
        username: 'sofia.bites',
        message: ' started following you.',
        time: '1h ago',
        avatarColor: lightAvatar,
        initialsColor: dark,
        tileColor: tileLight,
        isUnread: true,
      ),
    ]);

    earlierNotifications.assignAll([
      const NotificationItem(
        initials: 'LM',
        username: 'lucas.m',
        message: ' liked your review of Miso Ramen.',
        time: '5h ago',
        avatarColor: terracotta,
        initialsColor: Colors.white,
        tileColor: tileDark,
      ),
      const NotificationItem(
        initials: 'HK',
        username: 'hira.cooks',
        message: ' saved your review of Saffron Table.',
        time: 'Yesterday',
        avatarColor: dark,
        initialsColor: Colors.white,
        tileColor: tileDark,
      ),
      const NotificationItem(
        initials: 'PN',
        username: 'priya.r',
        message: ' commented: "Which dish would you order first?"',
        time: '2d ago',
        avatarColor: lightAvatar,
        initialsColor: dark,
        tileColor: tileLight,
      ),
      const NotificationItem(
        initials: 'OS',
        username: 'omar.s',
        message: ' started following you.',
        time: '3d ago',
        avatarColor: terracotta,
        initialsColor: Colors.white,
        tileColor: tileLight,
      ),
      const NotificationItem(
        initials: 'MT',
        username: 'mei.tanaka',
        message: ' liked your review of Pistachio Croissant.',
        time: '4d ago',
        avatarColor: dark,
        initialsColor: Colors.white,
        tileColor: tileLight,
      ),
    ]);
  }
}
