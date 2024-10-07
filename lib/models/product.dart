import 'package:dinde_market/models/product_photo.dart';
import 'package:dinde_market/models/sub_category.dart';

class Product {
  final int id;
  final String name;
  final List<ProductPhoto> photos;
  final double price;
  final String description;
  final int subCategoryId;
  final DateTime releaseDate;
  bool favorite;
  final int count;
  final double discount;
  int amount;

  Product({
    required this.id,
    required this.name,
    required this.photos,
    required this.price,
    required this.description,
    required this.subCategoryId,
    this.favorite = false,
    required this.count,
    required this.discount,
    this.amount =0,
    required this.releaseDate,
  });

  Product copyWith({
    int? id,
    String? name,
    List<ProductPhoto>? photos,
    double? price,
    String? description,
    SubCategory? subCategory,
    bool? favorite,
    int? count,
    double? discount,
    bool? newProduct,
    bool? seasonal,
    int? amount,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      photos: photos ?? this.photos,
      price: price ?? this.price,
      description: description ?? this.description,
      subCategoryId: subCategoryId,
      favorite: favorite ?? this.favorite,
      count: count ?? this.count,
      discount: discount ?? this.discount,
      amount: amount ?? this.amount,
      releaseDate: releaseDate,
    );
  }

   factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      photos: (json['photos'] as List)
          .map((photo) => ProductPhoto.fromJson(photo))
          .toList(),
      price: json['price'],
      subCategoryId: json['subcategoryId'],
      releaseDate: DateTime.parse(json['releaseDate']),
      count: json['count'],
      discount: json['discount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
