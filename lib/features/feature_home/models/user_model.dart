class UserModel {
  final String name;
  final String email;
  final String photoUrl;
  final int dailyGoal;

  const UserModel({
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.dailyGoal,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photo_url'] ?? '',
      dailyGoal: json['daily_goal'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'daily_goal': dailyGoal,
    'email': email,
    'name': name,
    'photo_url': photoUrl,
  };
}