import 'package:dinde_market/models/product.dart';
import 'package:intl/intl.dart';

class Order{
  final int id;
  final int orderNumber;
  final Map<OrderStatus, DateTime> orderStatus;
  final String marketName;
  final String customerName;
  final CustomerAddress customerAddress;
  final List<Product> orderedProducts;
  final int totalOrderPrice;
  final DateTime orderDate;
  final int totalDiscount;
  final String receiptMessage;

  Order({required this.receiptMessage, required this.totalDiscount, required this.id, required this.orderNumber, required this.orderStatus, required this.marketName, required this.customerName, required this.customerAddress, required this.orderedProducts, required this.totalOrderPrice, required this.orderDate});

  void setOrderDateTime(OrderStatus status, DateTime dateTime) {
    orderStatus[status] = dateTime;
  }
  String getOrderDateTime(OrderStatus status) {
    try{
      String dateTime = DateFormat('MM.dd.yyyy/ hh:mm').format(orderStatus[status]!);
    return dateTime;
    }catch(e) {
      return "";
    }
    
  }
  String getOrderDate(OrderStatus status) {
    try{
      String dateTime = DateFormat('MM.dd.yyyy').format(orderStatus[status]!);
    return dateTime;
    }catch(e) {
      return "";
    }
    
  }
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