class User {
  final String id;
  final String username;
  final String? avatarPath;

  User({
    required this.id,
    required this.username,
    this.avatarPath,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      avatarPath: json['avatar_path'],
    );
  }
}
