import 'dart:convert';

import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/pages/navigation_bar_page.dart';
import 'package:dinde_market/pages/opening_pages/district_page.dart';
import 'package:dinde_market/provider/products_provider.dart';
import 'package:dinde_market/provider/token_provider.dart';
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // _secureStorage.delete(key: 'auth_token');
      await getToken(_secureStorage, ref);
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('http://dindemarket.eu-north-1.elasticbeanstalk.com/api/products'), headers: {'Authorization': 'Bearer ${ref.read(tokenProvider)}', 'Content-Type': 'application/json'},);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the JSON.
      var decodeFormat = utf8.decode(response.bodyBytes);
      var data = json.decode(decodeFormat);
      if (data is List) {
        List<Product> productList = data.map((json) => Product.fromJson(json)).cast<Product>().toList();
        ref.read(productListProvider.notifier).state = productList;
      } else {
        print('Error: Decoded data is not a list');
      }
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }

Future<void> getToken(FlutterSecureStorage storage, WidgetRef ref) async {
  String? token = await storage.read(key: "auth_token");
  if (token != null) {
    ref.read(tokenProvider.notifier).state = token;
    fetchProducts();
  } else {
    ref.read(tokenProvider.notifier).state = "";
  }
}


  @override
  Widget build(BuildContext context) {
    final token = ref.read(tokenProvider.notifier).state;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: token == "" ? const DistrictPage() : const NavigationBarPage(),
    );
  }
}
