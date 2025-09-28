import '../../domain/entities/dish.dart';

abstract class DishEvent {}

class AddDishRequested extends DishEvent {
  final Dish dish;
  AddDishRequested(this.dish);
}