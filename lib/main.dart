// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:dinde_market/config/database_configuration.dart';
import 'package:dinde_market/models/db_cart_product.dart';
import 'package:dinde_market/models/db_favorite_product.dart';
import 'package:dinde_market/models/order.dart';
import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/models/user.dart';
import 'package:dinde_market/pages/navigation_bar_page.dart';
import 'package:dinde_market/pages/opening_pages/district_page.dart';
import 'package:dinde_market/provider/order_provider.dart';
import 'package:dinde_market/provider/products_provider.dart';
import 'package:dinde_market/provider/token_provider.dart';
import 'package:dinde_market/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  // bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // _secureStorage.delete(key: 'auth_token');
      await getToken(_secureStorage, ref);
      await fetchProducts();
      // setState(() {
      //   _isLoading = false;
      // });
    });
  }

  Future<void> fetchProducts() async {
    final response = await http.get(
      Uri.parse(
          'http://dindemarket.eu-north-1.elasticbeanstalk.com/api/products'),
      headers: {
        'Authorization': 'Bearer ${ref.read(tokenProvider)}',
        'Content-Type': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the JSON.
      var decodeFormat = utf8.decode(response.bodyBytes);
      var data = json.decode(decodeFormat);
      if (data is List) {
        List<Product> productList =
            data.map((json) => Product.fromJson(json)).cast<Product>().toList();

        List<DbFavoriteProduct> dbFavorite = await fetchFavoriteProducts();
        List<int> dbFavoriteID =
            dbFavorite.map((dbProduct) => dbProduct.id).toList();

            
        List<DbCartProduct> dbInCart = await fetchProductsInCart();
        List<int> dbInCartID =
            dbInCart.map((dbProduct) => dbProduct.id).toList();

        // User user = await fetchUserFromDb();

        productList = productList.map((product) {
          if(dbInCartID.contains(product.id)) {
            return product.copyWith(amount: dbInCart.firstWhere((cart) => cart.id == product.id).amount);
          }
          return product;
        }).toList();

        productList = productList.map((product) {
          if(dbFavoriteID.contains(product.id)) {
            return product.copyWith(favorite: true);
          }
          return product;
        }).toList();
        
        ref.read(productListProvider.notifier).state = productList;

      
        // ref.read(userProvider.notifier).updateUser(user);
      } else {
        print('Error: Decoded data is not a list');
      }
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }

  void clearDatabase() async {
    await DatabaseHelper.instance.resetDatabase();
  }

  Future<void> fetchOrders() async {
    final response = await http.get(
      Uri.parse(
          'http://dindemarket.eu-north-1.elasticbeanstalk.com/api/orders'),
      headers: {
        'Authorization': 'Bearer ${ref.read(tokenProvider)}',
        'Content-Type': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the JSON.
      var decodeFormat = utf8.decode(response.bodyBytes);
      var data = json.decode(decodeFormat);
      if (data is List) {
        print("####################");
        print("####################");
        print("####################");
        print("####################");
        List<Order> orderList =
            data.map((json) => Order.fromJson(json)).toList();
        print("***********************");
        print("***********************");
        print("***********************");
        print("***********************");
        print("***********************");
        print(orderList.first.totalDiscount);
        ref.read(orderProvider.notifier).state = orderList;
      } else {
        print('Error: Decoded data is not a list');
      }
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<List<DbFavoriteProduct>> fetchFavoriteProducts() async {
    List<Map<String, dynamic>> favoriteItems =
        await DatabaseHelper.instance.queryAllFavoriteItems();
    return favoriteItems
        .map((item) => DbFavoriteProduct.fromFavoriteMap(item))
        .toList();
  }

  Future<List<DbCartProduct>> fetchProductsInCart() async {
    List<Map<String, dynamic>> favoriteItems =
        await DatabaseHelper.instance.queryAllCartItems();
    return favoriteItems
        .map((item) => DbCartProduct.fromCartMap(item))
        .toList();
  }

  Future<User> fetchUserFromDb() async {
    List<Map<String, dynamic>> user =
        await DatabaseHelper.instance.queryAllUsers();
    return User.fromMap(user.first);
  }

  Future<void> getToken(FlutterSecureStorage storage, WidgetRef ref) async {
    String? token = await storage.read(key: "auth_token");
    if (token != null) {
      ref.read(tokenProvider.notifier).state = token;
      // fetchProducts();
      // clearDatabase();
      // fetchOrders();
    } else {
      ref.read(tokenProvider.notifier).state = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final token = ref.read(tokenProvider.notifier).state;

    // if (_isLoading) {
    //   return const Center(child: CircularProgressIndicator());
    // }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: token == "" ? const DistrictPage() : const NavigationBarPage(),
    );
  }
}
