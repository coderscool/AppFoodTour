import '../../domain/entities/cart_item.dart';

abstract class CartEvent {}
class AddDishRequested extends CartEvent {
  final CartItem item;
  AddDishRequested(this.item);
}