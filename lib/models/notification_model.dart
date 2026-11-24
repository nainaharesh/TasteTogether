
import 'package:flutter/material.dart';

class NotificationItem {
  final String initials;
  final String username;
  final String message;
  final String time;

  final Color avatarColor;
  final Color initialsColor;
  final Color tileColor;

  final bool isUnread;

  const NotificationItem({
    required this.initials,
    required this.username,
    required this.message,
    required this.time,
    required this.avatarColor,
    required this.initialsColor,
    required this.tileColor,
    this.isUnread = false,
  });
}
