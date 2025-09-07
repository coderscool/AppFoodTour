import 'package:appfoodtour/features/welcome/presentation/screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

void main() {
  final remoteDataSource = AuthRemoteDataSourceImpl();

  final authRepository = AuthRepositoryImpl(remoteDataSource);

  final loginUseCase = LoginUseCase(authRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(loginUseCase),
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
