class AppNotification {
  final String id;
  final String username;
  final String initials;

  /// UserAvatar ka style: 0 = sand, 1 = terracotta, 2 = charcoal
  final int avatarStyle;

  /// username ke baad ka text, e.g. "liked your review of Miso Ramen."
  final String message;
  final String timeAgo;
  final bool isUnread;

  /// review/photo wali notification mein chhota thumbnail dikhta hai
  final bool hasThumbnail;

  const AppNotification({
    required this.id,
    required this.username,
    required this.initials,
    required this.avatarStyle,
    required this.message,
    required this.timeAgo,
    this.isUnread = false,
    this.hasThumbnail = true,
  });

  AppNotification copyWith({bool? isUnread}) => AppNotification(
    id: id,
    username: username,
    initials: initials,
    avatarStyle: avatarStyle,
    message: message,
    timeAgo: timeAgo,
    isUnread: isUnread ?? this.isUnread,
    hasThumbnail: hasThumbnail,
  );

  ////  later on API use here (fromJson) ////
}

/// Dummy data later remove and we use api ////
const List<AppNotification> dummyNotifications = [
  AppNotification(
    id: '1',
    username: 'amina.eats',
    initials: 'AR',
    avatarStyle: 1,
    message: 'liked your review of Charred Lamb Kofta.',
    timeAgo: '2m ago',
    isUnread: true,
  ),
  AppNotification(
    id: '2',
    username: 'danny_dines',
    initials: 'DO',
    avatarStyle: 2,
    message: 'commented: "Need to try this place this weekend!"',
    timeAgo: '18m ago',
    isUnread: true,
  ),
  AppNotification(
    id: '3',
    username: 'sofia.bites',
    initials: 'SM',
    avatarStyle: 0,
    message: 'started following you.',
    timeAgo: '1h ago',
    isUnread: true,
    hasThumbnail: false,
  ),
  AppNotification(
    id: '4',
    username: 'lucas.m',
    initials: 'LM',
    avatarStyle: 1,
    message: 'liked your review of Miso Ramen.',
    timeAgo: '5h ago',
  ),
  AppNotification(
    id: '5',
    username: 'hira.cooks',
    initials: 'HK',
    avatarStyle: 2,
    message: 'saved your review of Saffron Table.',
    timeAgo: 'Yesterday',
  ),
  AppNotification(
    id: '6',
    username: 'priya.n',
    initials: 'PN',
    avatarStyle: 0,
    message: 'commented: "Which dish would you order first?"',
    timeAgo: '2d ago',
  ),
  AppNotification(
    id: '7',
    username: 'omar.s',
    initials: 'OS',
    avatarStyle: 1,
    message: 'started following you.',
    timeAgo: '3d ago',
    hasThumbnail: false,
  ),
  AppNotification(
    id: '8',
    username: 'mei.tanaka',
    initials: 'MT',
    avatarStyle: 2,
    message: 'liked your review of Pistachio Croissant.',
    timeAgo: '4d ago',
  ),
];
