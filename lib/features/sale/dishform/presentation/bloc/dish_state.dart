abstract class DishState {}

class DishInitial extends DishState {}

class DishLoading extends DishState {}

class DishSuccess extends DishState {}

class DishFailure extends DishState {
  final String message;
  DishFailure(this.message);
}
