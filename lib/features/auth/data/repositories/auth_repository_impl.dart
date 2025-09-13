import 'package:appfoodtour/features/auth/data/models/register_response_model.dart';
import 'package:geocoding/geocoding.dart';

import '../datasources/auth_local_datasource.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDatasource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDatasource);

  @override
  Future<User> login(String username, String password) async {
    final user = await remoteDataSource.login(username, password);
    localDatasource.saveLoginInfo(user.role, user.token, user.id);
    return user;
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
  ) async {
    final locations = await locationFromAddress(address);
    final latitude = locations.first.latitude;
    final longitude = locations.first.longitude;

    return remoteDataSource.registerSeller(username, password, name, address, phone,
      nation, startTime, endTime, imagePath, latitude, longitude);
  }

  @override
  Future<String?> getSavedToken() {
    return localDatasource.getUserId();
  }
}