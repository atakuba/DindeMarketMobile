import 'package:dinde_market/models/order.dart';
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
    SubCategory(id: 11, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 311, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 32, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 34, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 33, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 344, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 355, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 36, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 37, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 377, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3777, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3566, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 334, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 323423423, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3234, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 33234, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3234243, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 32112, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3111, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3999999, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 399999, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 39999, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3999, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 399, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 388, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 83, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 3888, name: "Сгушеное молоко", category: MyCategories.categoryList[0]),
    SubCategory(id: 4, name: "Сливки, молочные коктейли", category: MyCategories.categoryList[0]),
    SubCategory(id: 885, name: "Сметана", category: MyCategories.categoryList[0]),
    SubCategory(id: 994, name: "Сливки, молочные коктейли", category: MyCategories.categoryList[2]),
    SubCategory(id: 565, name: "Сметана", category: MyCategories.categoryList[1]),
    SubCategory(id: 4, name: "Сливки, молочные коктейли", category: MyCategories.categoryList[2]),
    SubCategory(id: 765, name: "Сметана", category: MyCategories.categoryList[2]),
  ];
}
class MyProducts {
  static List<Product> productList =[
    Product(seasonal: true, newProduct: true, discount: 20, count: 0, favorite: true, id: 1, name: "aКефир отборный Коровка", picture: "assets/offers/news_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1],),
    Product(seasonal: true, newProduct: false, discount: 50, favorite: true, id: 16, name: "aКефир отборный Коровка", picture: "assets/offers/sales_pic.png", price: 1000.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(seasonal: true, newProduct: true, discount: 22, favorite: false, id: 2, name: "bКефир отборный Коровка", picture: "assets/offers/news_pic_content.png", price: 799.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(seasonal: true, newProduct: false, discount: 0, favorite: false, id: 3, name: "cКефир отборный Коровка", picture: "assets/offers/seasonal_products_pic.png", price: 699.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(seasonal: false, newProduct: false, discount: 20, favorite: false, id: 4, name: "bdКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 599.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[0]),
    Product(seasonal: false, newProduct: true, discount: 20, favorite: true, id: 5, name: "aeКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 499.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[2]),
    Product(seasonal: false, newProduct: false, discount: 20, favorite: false, id: 6, name: "fКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 399.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(seasonal: false, newProduct: true, discount: 20, favorite: false, id: 8, name: "jjКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 299.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(seasonal: false, newProduct: true, discount: 20, favorite: false, id: 9, name: "hКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 299.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(seasonal: false, newProduct: true, discount: 20, favorite: false, id: 10, name: "iКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 999.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(seasonal: false, newProduct: true, discount: 20, favorite: true, id: 11, name: "иКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(seasonal: false, newProduct: true, discount: 20, favorite: false, id: 12, name: "дКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(seasonal: false, newProduct: true, discount: 20, favorite: true, id: 13, name: "аКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(seasonal: false, newProduct: true, discount: 20, favorite: false, id: 14, name: "бКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(seasonal: false, newProduct: true, discount: 20, favorite: false, id: 15, name: "сКефир отборный Коровка", picture: "assets/products/milk_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
  ];
}

class OrderedProducts { 
  static List<Product> orderedProducts =[
  Product(seasonal: true, newProduct: true, discount: 20, count: 0, favorite: true, id: 1, name: "aКефир отборный Коровка", picture: "assets/offers/news_pic.png", price: 899.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1],),
    Product(seasonal: true, newProduct: true, discount: 50, favorite: true, id: 16, name: "aКефир отборный Коровка", picture: "assets/offers/sales_pic.png", price: 1000.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(seasonal: true, newProduct: true, discount: 22, count: 0, favorite: false, id: 2, name: "bКефир отборный Коровка", picture: "assets/offers/news_pic_content.png", price: 799.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    Product(seasonal: true, newProduct: true, discount: 0, favorite: false, id: 3, name: "cКефир отборный Коровка", picture: "assets/offers/seasonal_products_pic.png", price: 699.0, description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ", subCategory: MySubCategories.subCategoryList[1]),
    
];
}

class MyOrders {
  static List<Order> orderList = [
    Order(receiptMessage: "blabla", totalDiscount: 99, id: 1, orderNumber: 123, orderStatus: {OrderStatus.underReview: DateTime.now()}, marketName: "Dordoi", customerName: "Kiril", customerAddress: CustomerAddress(id: 1, city: "Бишкек", street: "ул. Медерова 40", customerCommments: "Пожалуйста предварительно позвоните мне"), orderedProducts: OrderedProducts.orderedProducts, totalOrderPrice: 5000, orderDate: DateTime.now()),
    Order(receiptMessage: "blabla",totalDiscount: 99, id: 2, orderNumber: 321, orderStatus: {OrderStatus.underReview: DateTime.now(), OrderStatus.accepted: DateTime.now().add(Duration(days: 2, hours: 5))}, marketName: "Tsum Aichurok", customerName: "Edil", customerAddress: CustomerAddress(id: 2, city: "Бишкек", street: "ул. Медерова 22222", customerCommments: "Пожалуйста предварительно позвоните мне"), orderedProducts: OrderedProducts.orderedProducts, totalOrderPrice: 22000, orderDate: DateTime.now()),
    Order(receiptMessage: "blabla",totalDiscount: 99, id: 1, orderNumber: 213, orderStatus: {OrderStatus.underReview: DateTime.now(), OrderStatus.accepted: DateTime.now().add(Duration(days: 2, hours: 5)), OrderStatus.completed: DateTime.now().add(Duration(days: 2, hours: 5))}, marketName: "Osh Bazar", customerName: "Danil", customerAddress: CustomerAddress(id: 3, city: "Бишкек", entrance: "3rd entrance", unit: "106", floor: "lobby", street: "ул. Медерова 404", customerCommments: "Пожалуйста предварительно позвоните мне"), orderedProducts: OrderedProducts.orderedProducts, totalOrderPrice: 100, orderDate: DateTime.now()),
  ];
}