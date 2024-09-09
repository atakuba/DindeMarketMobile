
import 'package:dinde_market/models/mock_data/mock_data.dart';
import 'package:dinde_market/models/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderProvider = StateProvider<List<Order>>((ref) => MyOrders.orderList.toList());

