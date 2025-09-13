import 'package:appfoodtour/features/auth/data/models/register_response_model.dart';
import '../models/user_model.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String username, String password);
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
      double latitude,
      double longitude);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel> login(String username, String password) async {
    final response = await client.get(
      ApiConstants.login,
      queryParameters: {
        "username": username,
        "password": password,
      },
    );
    return UserModel.fromJson(response.data);
  }

  @override
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
    double latitude,
    double longitude,
  ) async {
    final body = {
      "userName": username,
      "passWord": password,
      "seller": {
        "name": name,
        "image": imagePath,
        "address": {
          "address": address,
          "latitude": latitude,
          "longitude": longitude,
        },
        "phone": phone,
      },
      "image": imagePath,
      "nation": nation,
      "timeActive": {
        "start": startTime,
        "end": endTime,
      },
      "role": "seller",
    };
    print(body);
    final response = await client.post(
      ApiConstants.registerSeller,
      body
    );

    return RegisterResponseModel.fromJson(response["statusCode"]);
  }
}