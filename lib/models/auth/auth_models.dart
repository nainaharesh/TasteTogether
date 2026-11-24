/// Login / signup ke baad backend se aane wala user.
/// TODO: Postman response se baaki fields (avatar wagera) confirm karke add karo.
class UserModel {
  const UserModel({
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
    this.bio = '',
  });

  final String id;
  final String fullName;
  final String username;
  final String email;
  final String bio;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      fullName: (json['fullName'] ?? '') as String,
      username: (json['username'] ?? '') as String,
      email: (json['email'] ?? '') as String,
      bio: (json['bio'] ?? '') as String,
    );
  }
}

/// Login / signup ka response: { "token": "...", "user": { ... } }
class AuthResponse {
  const AuthResponse({required this.token, required this.user});

  final String token;
  final UserModel user;

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
