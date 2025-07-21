class UserModel {
  final String name;
  final String welcomeMessage;
  final String hostelName;
  final String? avatarUrl;

  const UserModel({
    required this.name,
    required this.welcomeMessage,
    required this.hostelName,
    this.avatarUrl,
  });
}
