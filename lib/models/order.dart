import 'package:dinde_market/models/product.dart';
import 'package:intl/intl.dart';

class Order {
  final int id;
  final Map<OrderStatus, DateTime> orderStatus;
  final String customerFirstName;
  final String customerLastName;
  final double deliveryPrice;
  final CustomerAddress customerAddress;
  final List<Product> orderedProducts;
  final double totalOrderPrice;
  final double totalDiscount;
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

  Order copyWith({
    int? id,
    Map<OrderStatus, DateTime>? orderStatus,
    String? customerFirstName,
    String? customerLastName,
    double? deliveryPrice,
    CustomerAddress? customerAddress,
    List<Product>? orderedProducts,
    double? totalOrderPrice,
    double? totalDiscount,
    String? phoneNumber,
  }) {
    return Order(
      id: id ?? this.id,
      orderStatus: orderStatus ?? this.orderStatus,
      customerFirstName: customerFirstName ?? this.customerFirstName,
      customerLastName: customerLastName ?? this.customerLastName,
      deliveryPrice: deliveryPrice ?? this.deliveryPrice,
      customerAddress: customerAddress ?? this.customerAddress,
      orderedProducts: orderedProducts ?? this.orderedProducts,
      totalOrderPrice: totalOrderPrice ?? this.totalOrderPrice,
      totalDiscount: totalDiscount ?? this.totalDiscount,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  void setOrderDateTime(OrderStatus status, DateTime dateTime) {
    orderStatus[status] = dateTime;
  }

  String getOrderDateTime(OrderStatus status) {
    try {
      String dateTime =
          DateFormat('MM.dd.yyyy/ hh:mm').format(orderStatus[status]!);
      return dateTime;
    } catch (e) {
      return "";
    }
  }

  String getOrderDate(OrderStatus status) {
    try {
      String dateTime = DateFormat('MM.dd.yyyy').format(orderStatus[status]!);
      return dateTime;
    } catch (e) {
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
      if (statusValue == 'PENDING') {
        statusMap[OrderStatus.underReview] = statusTime;
      }
      if(statusValue == 'PAID') {
        statusMap[OrderStatus.accepted] = statusTime;
      }
    }

    List<Product> prods = (json['products'] as List).map((productJson) {
      var product = Product.fromJson(productJson['product']);
      var quantity = productJson['quantity'];
      product.amount = quantity; // Assuming Product has a quantity field
      return product;
    }).toList();

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
      customerAddress: CustomerAddress(
        city: json['city'],
        street: json['street'],
        unit: json['unit'],
        entrance: json['entrance'],
        floor: json['floor'],
        customerCommments: json['comment'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> statusMap = orderStatus.entries.map((entry) {
      String status = entry.key.toString();
      if (status == 'OrderStatus.underReview') {
        status = 'PENDING';
      }
      return {
        'id': null,
        'status': status, // Convert enum to string
        'statusTime':
            entry.value.toIso8601String() // Convert DateTime to string
      };
    }).first;

    List<Map<String, dynamic>> productsJson = orderedProducts.map((product) {
      return {
        'productId': product.id, // Assuming Product has a toJson() method
        'quantity':
            product.amount // Assuming Product has a quantity field named amount
      };
    }).toList();

    return {
      'products': productsJson,
      'totalAmount': totalOrderPrice,
      'discount': totalDiscount,
      'orderStatus': statusMap,
      'phoneNumber': phoneNumber,
      'comment': customerAddress.customerCommments,
      'firstName': customerFirstName,
      'lastName': customerLastName,
      'city': customerAddress.city,
      'street': customerAddress.street,
      'unit': customerAddress.unit,
      'entrance': customerAddress.entrance,
      'floor': customerAddress.floor,
    };
  }
}

enum OrderStatus {
  underReview,
  accepted,
  completed,
}

class CustomerAddress {
  final String city;
  final String street;
  final String? unit;
  final String? entrance;
  final String? floor;
  final String customerCommments;

  CustomerAddress(
      {required this.city,
      required this.street,
      this.unit,
      this.entrance,
      this.floor,
      required this.customerCommments});
}
