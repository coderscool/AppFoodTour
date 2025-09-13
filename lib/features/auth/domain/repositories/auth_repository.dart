import 'package:appfoodtour/features/auth/data/models/register_response_model.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String username, String password);
  Future<RegisterResponseModel> registerSeller(
      String username,
      String password,
      String name,
      String address,
      String phone,
      String nation,
      int startTime,
      int endTime,
      String imagePath,
      );
}