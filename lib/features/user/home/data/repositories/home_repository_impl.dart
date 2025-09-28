import 'package:appfoodtour/features/user/home/domain/entities/near_store.dart';
import 'package:appfoodtour/features/user/home/domain/entities/trending_dish.dart';

import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<TrendingDish>> getTrendingDishes() async {
    final dish = remoteDataSource.getDish();
    return dish;
  }

  @override
  Future<List<NearStore>> getNearStores(double latitude, double longitude) async {
    return [

    ];
  }
}
