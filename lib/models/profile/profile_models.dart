/// The user's profile as the screens need it.
///
/// BACKEND INTEGRATION: the real field names depend on the backend response,
/// so fromJson / toJson are commented out. Adjust the fields below once you
/// receive a sample response.
class ProfileModel {
  final String fullName;
  final String username;
  final String bio;
  final String email; // shown in Settings, not editable in the design
  final String? avatarUrl; // null = show initials

  const ProfileModel({
    required this.fullName,
    required this.username,
    required this.bio,
    required this.email,
    this.avatarUrl,
  });

// factory ProfileModel.fromJson(Map<String, dynamic> json) {
//   // TODO(backend): map the real keys here
// }

// Map<String, dynamic> toJson() {
//   // TODO(backend): map the real keys here
// }
}