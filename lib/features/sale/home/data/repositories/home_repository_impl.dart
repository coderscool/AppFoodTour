import 'package:appfoodtour/features/sale/home/data/datasources/home_remote_datasource.dart';

import '../../domain/entities/dish.dart';
import '../../domain/entities/stat.dart';
import '../../domain/repositories/home_repository.dart';
import '../models/dish_model.dart';
import '../models/stat_model.dart';
import 'package:flutter/material.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Dish>> getDishes(String id) async {
    final dish = remoteDataSource.getDish(id);
    return dish;
  }

  @override
  Future<List<Stat>> getStats() async {
    return [
      StatModel(icon: Icons.monetization_on, title: 'Doanh thu', value: '25.000.000₫'),
      StatModel(icon: Icons.shopping_cart, title: 'Đơn hàng', value: '520'),
      StatModel(icon: Icons.fastfood, title: 'Món ăn', value: '18'),
      StatModel(icon: Icons.people, title: 'Khách hàng', value: '230'),
    ];
  }
}
