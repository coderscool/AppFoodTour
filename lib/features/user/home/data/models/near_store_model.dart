import '../../domain/entities/near_store.dart';

class NearStoreModel extends NearStore {
  NearStoreModel({required super.id, required super.name, required super.image,
    required super.description, required super.address, required super.avgRate});

  factory NearStoreModel.fromJson(Map<String, dynamic> json) {
    return NearStoreModel(
        id: json['id'],
        name: json['dish']['name'],
        image: json['dish']['image'],
        description: json['dish']['description'],
        address: json['quantity'],
        avgRate: json['price']
    );
  }
}