import '../entities/dish.dart';
import '../repositories/dish_repository.dart';

class AddDish {
  final DishRepository repository;

  AddDish(this.repository);

  Future<void> call(Dish dish) {
    return repository.addDish(dish);
  }
}