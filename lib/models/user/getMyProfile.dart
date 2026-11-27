// To parse this JSON data, do
//
//     final getMyProfile = getMyProfileFromJson(jsonString);

import 'dart:convert';

GetMyProfile getMyProfileFromJson(String str) => GetMyProfile.fromJson(json.decode(str));

String getMyProfileToJson(GetMyProfile data) => json.encode(data.toJson());

class GetMyProfile {
  final String? id;
  final String? fullName;
  final String? username;
  final String? bio;
  final dynamic avatarUrl;
  final String? avatarColor;
  final int? followerCount;
  final int? followingCount;
  final int? reviewCount;
  final DateTime? createdAt;
  final String? email;
  final PushPrefs? pushPrefs;
  final EmailPrefs? emailPrefs;

  GetMyProfile({
    this.id,
    this.fullName,
    this.username,
    this.bio,
    this.avatarUrl,
    this.avatarColor,
    this.followerCount,
    this.followingCount,
    this.reviewCount,
    this.createdAt,
    this.email,
    this.pushPrefs,
    this.emailPrefs,
  });

  factory GetMyProfile.fromJson(Map<String, dynamic> json) => GetMyProfile(
    id: json["id"],
    fullName: json["fullName"],
    username: json["username"],
    bio: json["bio"],
    avatarUrl: json["avatarUrl"],
    avatarColor: json["avatarColor"],
    followerCount: json["followerCount"],
    followingCount: json["followingCount"],
    reviewCount: json["reviewCount"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    email: json["email"],
    pushPrefs: json["pushPrefs"] == null ? null : PushPrefs.fromJson(json["pushPrefs"]),
    emailPrefs: json["emailPrefs"] == null ? null : EmailPrefs.fromJson(json["emailPrefs"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "username": username,
    "bio": bio,
    "avatarUrl": avatarUrl,
    "avatarColor": avatarColor,
    "followerCount": followerCount,
    "followingCount": followingCount,
    "reviewCount": reviewCount,
    "createdAt": createdAt?.toIso8601String(),
    "email": email,
    "pushPrefs": pushPrefs?.toJson(),
    "emailPrefs": emailPrefs?.toJson(),
  };
}

class EmailPrefs {
  final bool? tips;
  final bool? digest;

  EmailPrefs({
    this.tips,
    this.digest,
  });

  factory EmailPrefs.fromJson(Map<String, dynamic> json) => EmailPrefs(
    tips: json["tips"],
    digest: json["digest"],
  );

  Map<String, dynamic> toJson() => {
    "tips": tips,
    "digest": digest,
  };
}

class PushPrefs {
  final bool? likes;
  final bool? saves;
  final bool? follows;
  final bool? comments;

  PushPrefs({
    this.likes,
    this.saves,
    this.follows,
    this.comments,
  });

  factory PushPrefs.fromJson(Map<String, dynamic> json) => PushPrefs(
    likes: json["likes"],
    saves: json["saves"],
    follows: json["follows"],
    comments: json["comments"],
  );

  Map<String, dynamic> toJson() => {
    "likes": likes,
    "saves": saves,
    "follows": follows,
    "comments": comments,
  };
}
