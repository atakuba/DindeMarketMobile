// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:dinde_market/config/database_configuration.dart';
import 'package:dinde_market/models/order.dart';
import 'package:dinde_market/pages/navigation_bar_page.dart';
import 'package:dinde_market/pages/opening_pages/district_page.dart';
import 'package:dinde_market/provider/order_provider.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // clearDatabase();
      // _secureStorage.delete(key: 'auth_token');
      await getToken(_secureStorage, ref);
      setState(() {
      });
    });
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

  Future<void> getToken(FlutterSecureStorage storage, WidgetRef ref) async {
    String? token = await storage.read(key: "auth_token");
    if (token != null) {
      ref.read(tokenProvider.notifier).state = token;
    } else {
      ref.read(tokenProvider.notifier).state = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final token = ref.read(tokenProvider.notifier).state;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: token == "" ? const DistrictPage() : const NavigationBarPage(),
    );
  }
}
