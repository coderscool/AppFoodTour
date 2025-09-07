import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required String id, required String token, required String role})
      : super(id: id, token: token, role: role);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      token: json['token'],
      role: json['role']
    );
  }
}