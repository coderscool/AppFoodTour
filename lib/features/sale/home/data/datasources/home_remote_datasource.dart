import 'dart:convert';
import 'package:appfoodtour/core/network/api_constants.dart';
import 'package:appfoodtour/core/network/dio_client.dart';
import 'package:appfoodtour/features/sale/home/data/models/dish_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<DishModel>> getDish(String id);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient client;

  HomeRemoteDataSourceImpl(this.client);

  @override
  Future<List<DishModel>> getDish(String id) async {
    final response = await client.get(
      ApiConstants.getDishes,
      queryParameters: {
        "id": id
      },
    );
    if(response.statusCode == 204){
      return <DishModel>[];
    }else{
      final List<dynamic> data = jsonDecode(response.data) as List<dynamic>;
      return data.map((e) => DishModel.fromJson(e as Map<String, dynamic>)).toList();
    }
  }
}