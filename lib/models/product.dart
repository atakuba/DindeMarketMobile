import 'package:dinde_market/models/sub_category.dart';

class Product {
  final int id;
  final String name;
  final String picture;
  final double price;
  final String description;
  final SubCategory subCategory;
  bool favorite;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.picture,
    required this.price,
    required this.description,
    required this.subCategory,
    this.favorite = false,
    this.quantity = 0,
  });

  Product copyWith({
    int? id,
    String? name,
    String? picture,
    double? price,
    String? description,
    SubCategory? subCategory,
    bool? favorite,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      picture: picture ?? this.picture,
      price: price ?? this.price,
      description: description ?? this.description,
      subCategory: subCategory ?? this.subCategory,
      favorite: favorite ?? this.favorite,
      quantity: quantity ?? this.quantity,
    );
  }
}
