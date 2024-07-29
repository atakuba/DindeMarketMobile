import 'package:dinde_market/models/sub_category.dart';

class Product {
  final int id;
  final String name;
  final String picture;
  final double price;
  final String description;
  final SubCategory subCategory;

  Product({required this.id, required this.name, required this.picture, required this.price, required this.description, required this.subCategory});
}