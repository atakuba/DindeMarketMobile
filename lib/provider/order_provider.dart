
import 'package:dinde_market/models/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderProvider = StateProvider<List<Order>>((ref) => []);

