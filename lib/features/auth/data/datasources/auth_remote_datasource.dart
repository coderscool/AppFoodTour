import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return UserModel(id: "1", token: "", role: "");
  }
}