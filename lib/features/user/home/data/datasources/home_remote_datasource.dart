import 'dart:convert';

import 'package:appfoodtour/core/network/api_constants.dart';
import 'package:appfoodtour/core/network/dio_client.dart';
import 'package:appfoodtour/features/user/home/data/models/near_store_model.dart';
import '../models/trending_dish_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<TrendingDishModel>> getDish();
  Future<List<NearStoreModel>> getNearStore(String address);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient client;

  HomeRemoteDataSourceImpl(this.client);

  @override
  Future<List<TrendingDishModel>> getDish() async {
    final response = await client.get(
      ApiConstants.getDishes
    );

    final List<dynamic> data = jsonDecode(response.data) as List<dynamic>;
    return data.map((e) => TrendingDishModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<NearStoreModel>> getNearStore(String address) async {
    final response = await client.get(
        ApiConstants.getDishes,
        queryParameters: {
          "longitude": "1"
        }
    );

    final List<dynamic> data = jsonDecode(response.data) as List<dynamic>;
    return data.map((e) => NearStoreModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}