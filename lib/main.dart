import 'package:appfoodtour/features/sale/home/data/datasources/home_remote_datasource.dart';
import 'package:appfoodtour/features/welcome/presentation/screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/network/dio_client.dart';
import 'features/sale/home/data/repositories/home_repository_impl.dart';
import 'features/sale/home/domain/usecases/get_home_data_usecase.dart';
import 'features/sale/home/presentation/bloc/home_bloc.dart';
import './core/injection.dart' as di;

void main() async {
  final dioClient = DioClient();

  final remote = HomeRemoteDataSourceImpl(dioClient);

  await  di.init();
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeBloc(GetHomeDataUsecase(HomeRepositoryImpl(remote))),
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
