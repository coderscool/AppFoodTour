import 'package:appfoodtour/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:appfoodtour/features/auth/domain/usecases/register_seller_usecase.dart';
import 'package:appfoodtour/features/sale/home/data/datasources/home_remote_datasource.dart';
import 'package:appfoodtour/features/welcome/presentation/screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/network/dio_client.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/sale/home/data/repositories/home_repository_impl.dart';
import 'features/sale/home/domain/usecases/get_home_data_usecase.dart';
import 'features/sale/home/presentation/bloc/home_bloc.dart';

void main() {
  final dioClient = DioClient();

  final remoteDataSource = AuthRemoteDataSourceImpl(dioClient);
  final localDataSource = AuthLocalDataSourceImpl();

  final remote = HomeRemoteDataSourceImpl(dioClient);

  final authRepository = AuthRepositoryImpl(remoteDataSource, localDataSource);

  final loginUseCase = LoginUseCase(authRepository);
  final registerSellerUseCase = RegisterSellerUseCase(authRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeBloc(GetHomeDataUsecase(HomeRepositoryImpl(remote))),
        ),
        BlocProvider(
          create: (_) => AuthBloc(loginUseCase, registerSellerUseCase),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Tour App',
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(), // Luôn hiển thị màn hình Welcome khi mở app
    );
  }
}
