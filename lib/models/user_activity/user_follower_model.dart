
class UserFollowersResponse {
  const UserFollowersResponse({
    required this.users,
    required this.page,
    required this.limit,
  });

  final List<FollowerUserModel> users;
  final int page;
  final int limit;

  factory UserFollowersResponse.fromJson(Map<String, dynamic> json) {
    final list = json['users'] as List? ?? const [];

    return UserFollowersResponse(
      users: list
          .map(
            (item) => FollowerUserModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 20,
    );
  }
}

class FollowerUserModel {
  const FollowerUserModel({
    required this.id,
    required this.fullName,
    required this.username,
    this.bio,
    this.avatarUrl,
    this.avatarColor,
    required this.followerCount,
    required this.followingCount,
    required this.reviewCount,
    required this.isFollowing,
    this.createdAt,
  });

  final String id;
  final String fullName;
  final String username;
  final String? bio;
  final String? avatarUrl;
  final String? avatarColor;
  final int followerCount;
  final int followingCount;
  final int reviewCount;
  final bool isFollowing;
  final DateTime? createdAt;

  factory FollowerUserModel.fromJson(Map<String, dynamic> json) {
    return FollowerUserModel(
      id: json['id'].toString(),
      fullName: (json['fullName'] ?? '') as String,
      username: (json['username'] ?? '') as String,
      bio: json['bio'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      avatarColor: json['avatarColor'] as String?,
      followerCount: ((json['followerCount'] ?? 0) as num).toInt(),
      followingCount: ((json['followingCount'] ?? 0) as num).toInt(),
      reviewCount: ((json['reviewCount'] ?? 0) as num).toInt(),
      isFollowing: (json['isFollowing'] ?? false) as bool,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt'].toString()),
    );
  }
}
