import 'package:appfoodtour/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:appfoodtour/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:appfoodtour/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:appfoodtour/features/auth/domain/repositories/auth_repository.dart';
import 'package:appfoodtour/features/auth/domain/usecases/login_usecase.dart';
import 'package:appfoodtour/features/auth/domain/usecases/register_seller_usecase.dart';
import 'package:appfoodtour/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

void initAuthSellerFeature(GetIt sl) {
  // Data source
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
          remoteDataSource: sl<AuthRemoteDataSource>(),
          localDatasource: sl<AuthLocalDataSource>(),
        ),
  );

  // UseCase
  sl.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(sl()),
  );
  sl.registerLazySingleton<RegisterSellerUseCase>(
        () => RegisterSellerUseCase(sl()),
  );

  // Bloc
  sl.registerFactory<AuthBloc>(
        () => AuthBloc(
          sl<LoginUseCase>(),
          sl<RegisterSellerUseCase>()
        )
  );
}