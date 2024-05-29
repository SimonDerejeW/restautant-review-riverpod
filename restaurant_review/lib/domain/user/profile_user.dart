class Profile_User {
  final String id;
  final String username;
  final String email;
  final String isOwner;

  Profile_User({
    required this.id,
    required this.username,
    required this.email,
    required this.isOwner,
  });
  Profile_User copyWith({
    String? id,
    String? username,
    String? email,
    String? isOwner,
  }) {
    return Profile_User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      isOwner: isOwner ?? this.isOwner,
    );
  }
}
