import 'dart:convert';
import 'package:dinde_market/config/database_configuration.dart';
import 'package:dinde_market/models/category.dart';
import 'package:dinde_market/models/db_cart_product.dart';
import 'package:dinde_market/models/db_favorite_product.dart';
import 'package:dinde_market/models/district.dart';
import 'package:dinde_market/models/order.dart';
import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/models/sub_category.dart';
import 'package:dinde_market/models/user.dart';
import 'package:dinde_market/pages/navigation_page/home_page/sub_category_page.dart';
import 'package:dinde_market/provider/cart_list_provider.dart';
import 'package:dinde_market/provider/district_provider.dart';
import 'package:dinde_market/provider/order_provider.dart';
import 'package:dinde_market/provider/product_category_provider.dart';
import 'package:dinde_market/provider/products_provider.dart';
import 'package:dinde_market/provider/token_provider.dart';
import 'package:dinde_market/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:dinde_market/widgets/category_card.dart';
import 'package:dinde_market/widgets/serach_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final GlobalKey<NavigatorState> homePageNavigatorKey =
      GlobalKey<NavigatorState>();
  var urlPrefix = "http://dindemarket.eu-north-1.elasticbeanstalk.com";
  List<Category> categoryList = [];
  List<Category> specialProductCategory = [];
  List<SubCategory> searchSubcategoryList = [];

  Future<void> fetchSearchSubcategories(String productName) async {
    final response = await http.get(
      Uri.parse(
        '$urlPrefix/subcategories/search?name=$productName',
      ),
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
        List<Category> fetchSpecialProducts = data
            .map((json) => Category.fromJson(json))
            .cast<Category>()
            .toList();
        setState(() {
          ref.read(specialProductCategoryProvider.notifier).state =
              fetchSpecialProducts;
        });
      } else {}
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchOrders() async {
    final response = await http.get(
      Uri.parse('$urlPrefix/api/orders'),
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
        List<Order> orderList =
            data.map((json) => Order.fromJson(json)).toList();

        ref.read(orderProvider.notifier).state = orderList;
      } else {
        print('Error: Decoded data is not a list');
      }
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchSpecialProducts() async {
    final response = await http.get(
      Uri.parse('$urlPrefix/api/categories/favorites'),
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
        List<Category> fetchSpecialProducts = data
            .map((json) => Category.fromJson(json))
            .cast<Category>()
            .toList();
        setState(() {
          ref.read(specialProductCategoryProvider.notifier).state =
              fetchSpecialProducts;
        });
      } else {}
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
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

        productList = productList.map((product) {
          if (dbInCartID.contains(product.id)) {
            return product.copyWith(
                amount: dbInCart
                    .firstWhere((cart) => cart.id == product.id)
                    .amount);
          }
          return product;
        }).toList();

        productList = productList.map((product) {
          if (dbFavoriteID.contains(product.id)) {
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

  Future<void> fetchCategories() async {
    final response = await http.get(
      Uri.parse('$urlPrefix/api/categories'),
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
        List<Category> categoryList = data
            .map((json) => Category.fromJson(json))
            .cast<Category>()
            .toList();
        setState(() {
          this.categoryList = categoryList;
        });
      } else {}
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

  Future<List<District>> getAllDistricts() async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    List<Map<String, dynamic>> districtList =
        await dbHelper.queryAllDistricts();
    return districtList.map((d) => District.fromMap(d)).toList();
  }

  Future<User> fetchUserFromDb() async {
    List<District> districts = await getAllDistricts();
    ref.read(districtProvider.notifier).state = districts;

    List<Map<String, dynamic>> users =
        await DatabaseHelper.instance.queryAllUsers();
    Map<String, dynamic> firstUserMap = users.first;
    User futureUser = User.fromMap(firstUserMap);

    if (futureUser.address == null) {
      futureUser = futureUser.copyWith(addresss: "Аддресс не указан");
    }

    if (futureUser.phoneNumber == null) {
      futureUser = futureUser.copyWith(phoneNumber: "+996 (000) 00 00 00");
    }
    District district = ref
        .read(districtProvider.notifier)
        .state
        .firstWhere((d) => d.name == futureUser.district);
    ref.read(deliveryPriceProvider.notifier).state = district.priceDelivery;
    futureUser = futureUser.copyWith(region: district);
    ref.read(userProvider.notifier).state = futureUser;
    return futureUser;
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
    fetchCategories();
    fetchSpecialProducts();
    fetchUserFromDb();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    specialProductCategory = ref.watch(specialProductCategoryProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Navigator(
        key: homePageNavigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          // Define your routes here
          WidgetBuilder builder;
          switch (settings.name) {
            default:
              builder =
                  (BuildContext context) => _buildHomePageContent(context);
          }
          return MaterialPageRoute(builder: builder);
        },
      ),
    );
  }

  Widget _buildHomePageContent(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 155,
          child: Container(
            padding: EdgeInsets.only(
              left: Utilities.setWidgetWidthByPercentage(context, 13.9),
              right: Utilities.setWidgetWidthByPercentage(context, 13.9),
              top: Utilities.setWidgetWidthByPercentage(context, 12.4),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: const AssetImage("assets/whats_app_logo.png"),
                    width: Utilities.setWidgetWidthByPercentage(context, 19.7),
                  ),
                  InkWell(
                    child: Image(
                      image: const AssetImage("assets/tiktok_logo.png"),
                      width:
                          Utilities.setWidgetWidthByPercentage(context, 19.7),
                    ),
                    onTap: () {
                      print(ref.read(tokenProvider));
                    },
                  ),
                  Image(
                    image: const AssetImage("assets/instagram_logo.png"),
                    width: Utilities.setWidgetWidthByPercentage(context, 19.7),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 657,
          child: Container(
            color: const Color.fromRGBO(244, 245, 249, 1),
            child: Column(
              children: [
                Expanded(
                  flex: 35,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomizedSearchBar(parentContext: context),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Utilities.setWidgetWidthByPercentage(
                                  context, 4.5)),
                          child: specialProductCategory.length != 0
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _specialOfferBox(
                                        context: context,
                                        specialCategory:
                                            specialProductCategory[0]),
                                    _specialOfferBox(
                                        context: context,
                                        specialCategory:
                                            specialProductCategory[1]),
                                    _specialOfferBox(
                                        context: context,
                                        specialCategory:
                                            specialProductCategory[2]),
                                  ],
                                )
                              : Container(),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(
                        left: Utilities.setWidgetWidthByPercentage(context, 5)),
                    child: const Text("Категории",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  flex: 53,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            Utilities.setWidgetWidthByPercentage(context, 4.3)),
                    child: _categoryScrollBar(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _specialOfferBox({
    required BuildContext context,
    required Category specialCategory,
    // required String text,
    // required String fileName
  }) {
    return InkWell(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                  width: Utilities.setWidgetWidthByPercentage(context, 28.8),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Image.network(
                    specialCategory.image,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text(
                        'Ошибка загрузки изображения',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.underline,
                            fontSize: 12),
                      );
                    },
                  )),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: Utilities.setWidgetWidthByPercentage(context, 28.8),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Text(
                  specialCategory.name,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SubCategoryPage(
                    subcategoryList: specialCategory.subCategoryList,
                    categoryName: specialCategory.name,
                  )));
        });
  }

  Widget _categoryScrollBar() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return CategoryCard(category: categoryList[index]);
      },
      scrollDirection: Axis.vertical,
      itemCount: categoryList.length,
    );
  }
}
