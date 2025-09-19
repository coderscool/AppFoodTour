import '../entities/dish.dart';
import '../entities/stat.dart';

abstract class HomeRepository {
  Future<List<Dish>> getDishes(String id);
  Future<List<Stat>> getStats();
}