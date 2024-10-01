import 'package:dinde_market/models/product.dart';

class SubCategory {
  final int id;
  final String name;
  final List<Product> productList;

  SubCategory({required this.id, required this.name, required this.productList});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      productList: (json['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList(),
    );
  }
}