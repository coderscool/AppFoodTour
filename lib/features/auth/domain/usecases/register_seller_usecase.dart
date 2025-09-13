import 'package:appfoodtour/features/auth/data/models/register_response_model.dart';

import '../repositories/auth_repository.dart';

class RegisterSellerUseCase {
  final AuthRepository repository;

  RegisterSellerUseCase(this.repository);

  Future<RegisterResponseModel> call(
    String username,
    String password,
    String name,
    String address,
    String phone,
    String nation,
    int startTime,
    int endTime,
    String imagePath,
  ) {
    return repository.registerSeller(
      username,
      password,
      name,
      address,
      phone,
      nation,
      startTime,
      endTime,
      imagePath,
    );
  }
}