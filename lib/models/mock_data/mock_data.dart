
import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/models/sub_category.dart';

import '../category.dart';

class MyCategories {
  static List<Category> categoryList = [
    Category(
      id: 1,
      name: "Молочные продукты, сыр, яйца",
      image: "assets/categories/vegitables.png"
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
    Product(favorite: true, id: 1, name: "aКефир отборный Коровка", picture: "assets/offers/news_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1],),
    Product(favorite: true, id: 16, name: "aКефир отборный Коровка", picture: "assets/offers/sales_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(favorite: false, id: 2, name: "bКефир отборный Коровка", picture: "assets/offers/news_pic_content.png", price: 799.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(favorite: false, id: 3, name: "cКефир отборный Коровка", picture: "assets/offers/seasonal_products_pic.png", price: 699.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(favorite: false, id: 4, name: "bdКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 599.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[0]),
    Product(favorite: true, id: 5, name: "aeКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 499.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[2]),
    Product(favorite: false, id: 6, name: "fКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 399.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(favorite: false, id: 8, name: "jjКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 299.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(favorite: false, id: 9, name: "hКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 299.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(favorite: false, id: 10, name: "iКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 999.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(favorite: true, id: 11, name: "иКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(favorite: false, id: 12, name: "дКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(favorite: true, id: 13, name: "аКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(favorite: false, id: 14, name: "бКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(favorite: false, id: 15, name: "сКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
  ];
}