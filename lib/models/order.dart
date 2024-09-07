import 'package:dinde_market/models/product.dart';

class Order{
  final int id;
  final int orderNumber;
  final OrderStatus orderStatus;
  final String marketName;
  final String customerName;
  final CustomerAddress customerAddress;
  final List<Product> orderedProducts;
  final int totalOrderPrice;
  final DateTime orderDate;

  Order({required this.id, required this.orderNumber, required this.orderStatus, required this.marketName, required this.customerName, required this.customerAddress, required this.orderedProducts, required this.totalOrderPrice, required this.orderDate});
}

enum OrderStatus {
  underReview,
  accepted,
  completed,
}

class CustomerAddress{
  final int id;
  final String city;
  final String street;
  final String? unit;
  final String? entrance;
  final String? floor;
  final String customerCommments;

  CustomerAddress({required this.id, required this.city, required this.street, this.unit, this.entrance, this.floor, required this.customerCommments});
}