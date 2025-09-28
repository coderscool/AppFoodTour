import '../entities/dish.dart';

abstract class DishRepository {
  Future<void> addDish(Dish dish);
}