// data/repositories/dish_repository_impl.dart
import '../../domain/entities/dish.dart';
import '../../domain/repositories/dish_repository.dart';
import '../models/dish_model.dart';

class DishRepositoryImpl implements DishRepository {
  @override
  Future<void> addDish(Dish dish) async {
    final model = DishModel(
      name: dish.name,
      image: dish.image,
      description: dish.description,
      cost: dish.cost,
      discount: dish.discount,
      quantity: dish.quantity,
      extras: dish.extras,
      categories: dish.categories,
      nation: dish.nation,
    );

    // TODO: Call API
    // await http.post('url', body: jsonEncode(model.toJson()));
  }
}
