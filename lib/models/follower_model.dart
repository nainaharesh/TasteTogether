class FollowerModel {
  final String name;
  final String username;
  final String initials;
  final String? profileImage;
  final bool isFollowing;

  const FollowerModel({
    required this.name,
    required this.username,
    required this.initials,
    this.profileImage,
    this.isFollowing = false,
  });
}