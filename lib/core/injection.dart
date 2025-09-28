import 'package:appfoodtour/core/network/dio_client.dart';
import 'package:appfoodtour/features/auth/auth_seller_injection.dart';
import 'package:appfoodtour/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Dio client
  sl.registerLazySingleton(() => DioClient());

  // SharedPreferences
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl());

  // Features
  initAuthSellerFeature(sl);
}