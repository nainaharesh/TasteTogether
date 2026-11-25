// ignore_for_file: deprecated_member_use

int toInt(dynamic v) => v is num ? v.toInt() : int.tryParse('$v') ?? 0;
bool toBool(dynamic v, {bool fallback = true}) => v is bool ? v : fallback;

/// Push notification switches: likes / saves / follows / comments.
class PushPrefs {
  const PushPrefs({
    this.likes = true,
    this.saves = true,
    this.follows = true,
    this.comments = true,
  });

  final bool likes;
  final bool saves;
  final bool follows;
  final bool comments;

  factory PushPrefs.fromJson(dynamic json) {
    final m = json is Map ? json : const {};
    return PushPrefs(
      likes: toBool(m['likes']),
      saves: toBool(m['saves']),
      follows: toBool(m['follows']),
      comments: toBool(m['comments']),
    );
  }

  Map<String, dynamic> toJson() => {
    'likes': likes,
    'saves': saves,
    'follows': follows,
    'comments': comments,
  };

  PushPrefs copyWith({
    bool? likes,
    bool? saves,
    bool? follows,
    bool? comments,
  }) {
    return PushPrefs(
      likes: likes ?? this.likes,
      saves: saves ?? this.saves,
      follows: follows ?? this.follows,
      comments: comments ?? this.comments,
    );
  }
}

/// Email switches: tips / digest.
class EmailPrefs {
  const EmailPrefs({this.tips = true, this.digest = true});

  final bool tips;
  final bool digest;

  factory EmailPrefs.fromJson(dynamic json) {
    final m = json is Map ? json : const {};
    return EmailPrefs(tips: toBool(m['tips']), digest: toBool(m['digest']));
  }

  Map<String, dynamic> toJson() => {'tips': tips, 'digest': digest};

  EmailPrefs copyWith({bool? tips, bool? digest}) {
    return EmailPrefs(tips: tips ?? this.tips, digest: digest ?? this.digest);
  }
}

/// GET / PATCH /api/users/me ka user. Login / signup ke response mein kuch
/// fields na hon to defaults lagte hain (phir loadProfile poora user le aata hai).
class UserModel {
  const UserModel({
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
    this.bio = '',
    this.avatarUrl,
    this.avatarColor,
    this.followerCount = 0,
    this.followingCount = 0,
    this.reviewCount = 0,
    this.createdAt,
    this.pushPrefs = const PushPrefs(),
    this.emailPrefs = const EmailPrefs(),
  });

  final String id;
  final String fullName;
  final String username;
  final String email;
  final String bio;

  /// null = photo nahi, avatarColor ke upar initials dikhao
  final String? avatarUrl;

  /// hex jaise "#6B9080" (helpers.colorFromHex se Color banta hai)
  final String? avatarColor;
  final int followerCount;
  final int followingCount;
  final int reviewCount;
  final DateTime? createdAt;
  final PushPrefs pushPrefs;
  final EmailPrefs emailPrefs;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    String? text(String key) {
      final v = json[key];
      return v == null || '$v'.isEmpty ? null : '$v';
    }

    return UserModel(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      fullName: (json['fullName'] ?? '').toString(),
      username: (json['username'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      bio: (json['bio'] ?? '').toString(),
      avatarUrl: text('avatarUrl'),
      avatarColor: text('avatarColor'),
      followerCount: toInt(json['followerCount']),
      followingCount: toInt(json['followingCount']),
      reviewCount: toInt(json['reviewCount']),
      createdAt: DateTime.tryParse('${json['createdAt']}'),
      pushPrefs: PushPrefs.fromJson(json['pushPrefs']),
      emailPrefs: EmailPrefs.fromJson(json['emailPrefs']),
    );
  }

  /// "Riley Example" -> "RE" (avatar par, photo na ho to)
  String get initials {
    final words = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty);
    return words.take(2).map((w) => w[0].toUpperCase()).join();
  }

  UserModel copyWith({
    String? fullName,
    String? username,
    String? bio,
    String? avatarUrl,
    PushPrefs? pushPrefs,
    EmailPrefs? emailPrefs,
  }) {
    return UserModel(
      id: id,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      email: email,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      avatarColor: avatarColor,
      followerCount: followerCount,
      followingCount: followingCount,
      reviewCount: reviewCount,
      createdAt: createdAt,
      pushPrefs: pushPrefs ?? this.pushPrefs,
      emailPrefs: emailPrefs ?? this.emailPrefs,
    );
  }
}

/// Login / signup ka response: { "token": "...", "user": { ... } }
class AuthResponse {
  const AuthResponse({required this.token, required this.user});

  final String token;
  final UserModel user;

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    final token = json['token']?.toString() ?? '';
    final user = json['user'];
    if (token.isEmpty || user is! Map) {
      // Server 200 de kar bhi token / user na de to login adhoora na ho
      throw const FormatException('token ya user missing');
    }
    return AuthResponse(
      token: token,
      user: UserModel.fromJson(user.cast<String, dynamic>()),
    );
  }
}
