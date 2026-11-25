// ignore_for_file: deprecated_member_use
class Comment {
  final String id;
  final String username;
  final String initials;
  final String text;
  final String timeAgo;
  final int likes;
  final bool isLiked;

  /// post ka author ho to "Author" badge dikhta hai
  final bool isAuthor;

  /// 0 = sand, 1 = terracotta, 2 = charcoal (avatar ka rang)
  final int avatarStyle;

  final List<Comment> replies;

  const Comment({
    required this.id,
    required this.username,
    required this.initials,
    required this.text,
    required this.timeAgo,
    this.likes = 0,
    this.isLiked = false,
    this.isAuthor = false,
    this.avatarStyle = 0,
    this.replies = const [],
  });

  Comment copyWith({int? likes, bool? isLiked, List<Comment>? replies}) {
    return Comment(
      id: id,
      username: username,
      initials: initials,
      text: text,
      timeAgo: timeAgo,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
      isAuthor: isAuthor,
      avatarStyle: avatarStyle,
      replies: replies ?? this.replies,
    );
  }

  ////  later on API use here ////
  // factory Comment.fromJson(Map<String, dynamic> json) {
  //   return Comment(
  //     id: json['id'],
  //     username: json['username'],
  //     initials: json['initials'],
  //     text: json['text'],
  //     timeAgo: json['time_ago'],
  //     likes: json['likes'] ?? 0,
  //     isLiked: json['is_liked'] ?? false,
  //     isAuthor: json['is_author'] ?? false,
  //     replies: (json['replies'] as List? ?? [])
  //         .map((e) => Comment.fromJson(e))
  //         .toList(),
  //   );
  // }
}

/// Dummy data later remove and we use api ////
const List<Comment> dummyComments = [
  Comment(
    id: 'c1',
    username: 'danny_dines',
    initials: 'DO',
    text: 'Need to try this place this weekend!',
    timeAgo: '18m',
    likes: 6,
    avatarStyle: 2,
  ),
  Comment(
    id: 'c2',
    username: 'sofia.bites',
    initials: 'SM',
    text: "Is the lamb spicy? Asking for a friend who can't handle heat.",
    timeAgo: '1h',
    likes: 3,
    isLiked: true,
    replies: [
      Comment(
        id: 'c2r1',
        username: 'amina.eats',
        initials: 'AR',
        text: 'Mild! The chilli comes in the side sauce, so you control it.',
        timeAgo: '50m',
        isAuthor: true,
        avatarStyle: 1,
      ),
    ],
  ),
  Comment(
    id: 'c3',
    username: 'lucas.m',
    initials: 'LM',
    text: 'That whipped feta looks unreal.',
    timeAgo: '3h',
    likes: 2,
    avatarStyle: 1,
  ),
  Comment(
    id: 'c4',
    username: 'hira.cooks',
    initials: 'HK',
    text: 'Booked for Saturday because of this review.',
    timeAgo: '5h',
    likes: 9,
    avatarStyle: 2,
  ),
];
