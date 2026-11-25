// ignore_for_file: deprecated_member_use
import 'package:get/get.dart';
import 'package:tastetogether/models/notification_model.dart';

class NotificationsViewModel extends GetxController {
  final RxList<AppNotification> items = <AppNotification>[].obs;

  List<AppNotification> get unread => items.where((n) => n.isUnread).toList();
  List<AppNotification> get earlier => items.where((n) => !n.isUnread).toList();

  /// Home ke bell par laal dot isi se dikhta hai
  int get unreadCount => unread.length;

  @override
  void onInit() {
    super.onInit();
    // TODO: Get data from api//
    // dumy data///
    items.assignAll(dummyNotifications);
  }

  /// Screen khulne par "New" wali sab read ho jati hain
  void markAllRead() {
    // TODO: API - mark as read
    items.assignAll([for (final n in items) n.copyWith(isUnread: false)]);
  }
}
