import 'package:appfoodtour/features/user/home/domain/entities/near_store.dart';
import 'package:appfoodtour/features/user/home/domain/entities/trending_dish.dart';

abstract class HomeRepository {
  Future<List<TrendingDish>> getTrendingDishes();
  Future<List<NearStore>> getNearStores(double latitude, double longitude);
}