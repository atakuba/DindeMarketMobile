
import 'package:dinde_market/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListProvider = StateProvider<List<Product>>((ref) => []);

