import 'package:dinde_market/models/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final specialProductCategoryProvider = StateProvider<List<Category>>((ref) => []);