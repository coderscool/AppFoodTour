import 'package:appfoodtour/features/auth/domain/entities/register_response.dart';

class RegisterResponseModel extends RegisterResponse {
  const RegisterResponseModel({required int statusCode})
      : super(statusCode: statusCode);

  factory RegisterResponseModel.fromJson(int statusCode) {
    return RegisterResponseModel(
      statusCode: statusCode,
    );
  }
}