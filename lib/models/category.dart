import 'package:dinde_market/models/sub_category.dart';

class Category {
  final int id;
  final String name;
  final String image;
  final List<SubCategory> subCategoryList;
  final DateTime creationDate;
  final bool favorites;
  Category({
    required this.subCategoryList,
    required this.id,
    required this.name,
    required this.image,
    required this.creationDate,
    required this.favorites,
  });
  
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['photo'],
      favorites: json['favorites'],
      creationDate: DateTime.parse(json['creationDate']),
      subCategoryList: (json['subcategories'] as List)
          .map((subcategory) => SubCategory.fromJson(subcategory))
          .toList(),
    );
  }
}