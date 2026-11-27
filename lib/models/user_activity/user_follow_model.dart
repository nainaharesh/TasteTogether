class UserFollowModel {
  const UserFollowModel({
    required this.isFollowing,
    required this.followerCount,
  });

  final bool isFollowing;
  final int followerCount;

  factory UserFollowModel.fromJson(Map<String, dynamic> json) {
    return UserFollowModel(
      isFollowing: json['isFollowing'] as bool? ?? false,
      followerCount: (json['followerCount'] as num?)?.toInt() ?? 0,
    );
  }
}