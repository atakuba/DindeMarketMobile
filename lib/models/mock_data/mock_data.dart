
import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/models/sub_category.dart';

import '../category.dart';

class MyCategories {
  static List<Category> categoryList = [
    Category(
      id: 1,
      name: "Молочные продукты, сыр, яйца",
      image: "assets/categories/dairy_pic.png"
    ),
    Category(
      id: 2,
      name: "Овощи",
      image: "assets/categories/vegitables.png"
    ),
    Category(
      id: 3,
      name: "Фрукты",
      image: "assets/categories/fruits.png"
    ),
    Category(
      id: 4,
      name: "Продукты питания",
      image: "assets/categories/foods.png"
    ),
    Category(
      id: 5,
      name: "Овощи",
      image: "assets/categories/vegitables.png"
    ),
    Category(
      id: 6,
      name: "Фрукты",
      image: "assets/categories/fruits.png"
    ),
    Category(
      id: 7,
      name: "Продукты питания",
      image: "assets/categories/foods.png"
    ),
    Category(
      id: 8,
      name: "Овощи",
      image: "assets/categories/vegitables.png"
    ),
    Category(
      id: 9,
      name: "Фрукты",
      image: "assets/categories/fruits.png"
    ),
    Category(
      id: 10,
      name: "Продукты питания",
      image: "assets/categories/foods.png"
    ),
    Category(
      id: 11,
      name: "Овощи",
      image: "assets/categories/vegitables.png"
    ),
    Category(
      id: 12,
      name: "Фрукты",
      image: "assets/categories/fruits.png"
    ),
    Category(
      id: 13,
      name: "Продукты питания",
      image: "assets/categories/foods.png"
    ),
    Category(
      id: 14,
      name: "Овощи",
      image: "assets/categories/vegitables.png"
    ),
    Category(
      id: 15,
      name: "Фрукты",
      image: "assets/categories/fruits.png"
    ),
  ];
}
class MySubCategories {
  static List<SubCategory> subCategoryList = [
    SubCategory(id: 1, name: "Кефир, айран", category: MyCategories.categoryList[0]),
    SubCategory(id: 2, name: "Молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 4, name: "Сливки, молочные коктейли", category: MyCategories.categoryList[0]),
    SubCategory(id: 5, name: "Сметана", category: MyCategories.categoryList[0]),
    SubCategory(id: 4, name: "Сливки, молочные коктейли", category: MyCategories.categoryList[2]),
    SubCategory(id: 5, name: "Сметана", category: MyCategories.categoryList[1]),
    SubCategory(id: 4, name: "Сливки, молочные коктейли", category: MyCategories.categoryList[2]),
    SubCategory(id: 5, name: "Сметана", category: MyCategories.categoryList[2]),
  ];
}
class MyProducts {
  static List<Product> productList =[
    Product(id: 1, name: "Кефир отборный Коровка", picture: "/assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(id: 1, name: "Кефир отборный Коровка", picture: "/assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(id: 1, name: "Кефир отборный Коровка", picture: "/assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(id: 1, name: "Кефир отборный Коровка", picture: "/assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(id: 1, name: "Кефир отборный Коровка", picture: "/assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(id: 1, name: "Кефир отборный Коровка", picture: "/assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(id: 1, name: "Кефир отборный Коровка", picture: "/assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(id: 1, name: "Кефир отборный Коровка", picture: "/assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(id: 1, name: "Кефир отборный Коровка", picture: "/assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(id: 1, name: "Кефир отборный Коровка", picture: "/assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(id: 1, name: "Кефир отборный Коровка", picture: "/assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(id: 1, name: "Кефир отборный Коровка", picture: "/assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(id: 1, name: "Кефир отборный Коровка", picture: "/assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(id: 1, name: "Кефир отборный Коровка", picture: "/assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
  ];
}