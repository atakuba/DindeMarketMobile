
import 'package:dinde_market/models/mock_data/mock_data.dart';
import 'package:dinde_market/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListProvider = StateProvider<List<Product>>((ref) => MyProducts.productList.toList());