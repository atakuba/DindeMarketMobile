import 'package:dinde_market/models/product.dart';
import 'package:intl/intl.dart';

class Order{
  final int id;
  final Map<OrderStatus, DateTime> orderStatus;
  final String customerFirstName;
  final String customerLastName;
  final double deliveryPrice;
  final CustomerAddress customerAddress;
  final List<Product> orderedProducts;
  final int totalOrderPrice;
  final int totalDiscount;
  final String phoneNumber;

  Order({ 
    required this.phoneNumber, 
    required this.totalDiscount, 
    required this.id, 
    required this.deliveryPrice, 
    required this.orderStatus, 
    required this.customerFirstName,
    required this.customerLastName, 
    required this.customerAddress, 
    required this.orderedProducts, 
    required this.totalOrderPrice, 
    });

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

  factory Order.fromJson(Map<String, dynamic> json) {
    Map<OrderStatus, DateTime> statusMap = {};

    for (var status in json['orderStatus']) {
      // OrderStatus orderStatusEnum = OrderStatus.values.firstWhere(
      //   (e) => e.toString().split('.').last == status['status'],
      // );
      DateTime statusTime = DateTime.parse(status['statusTime']);
      String statusValue = status['status'];
      
      // statusMap[orderStatusEnum] = statusTime;
      if(statusValue == 'PENDING') {
        statusMap[OrderStatus.underReview] = statusTime;
      }
    }
    
    List<Product> prods = (json['products'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList();
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      print(statusMap);
      print(prods.first);
    
    return Order(
      id: json['id'],
      orderedProducts: prods,
      totalOrderPrice: json['totalAmount'],
      totalDiscount: json['discount'],
      deliveryPrice: json['priceDelivery'],
      orderStatus: statusMap,
      phoneNumber: json['phoneNumber'],
      customerFirstName: json['firstName'],
      customerLastName: json['lastName'],
      customerAddress: CustomerAddress(city: json['city'], street: json['street'], unit: json['unit'], 
      entrance: json['entrance'], floor: json['floor'], customerCommments: json['comment'],),
      
      
      
      
      
    );
  }
}

enum OrderStatus {
  underReview,
  accepted,
  completed,
}

class CustomerAddress{  final String city;
  final String street;
  final String? unit;
  final String? entrance;
  final String? floor;
  final String customerCommments;

  CustomerAddress({required this.city, required this.street, this.unit, this.entrance, this.floor, required this.customerCommments});

}