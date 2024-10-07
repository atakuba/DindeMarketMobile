import 'dart:convert';

import 'package:dinde_market/provider/token_provider.dart';
import 'package:dinde_market/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dinde_market/models/order.dart';
import 'package:dinde_market/pages/navigation_page/cart_page/checkout_page.dart';
import 'package:dinde_market/pages/navigation_page/cart_page/receipt_page.dart';
import 'package:dinde_market/provider/cart_list_provider.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:http/http.dart' as http;

class TotalPriceWidget {
  static Future<void> postOrder(Order order, WidgetRef ref) async {
    final url = Uri.parse("http://dindemarket.eu-north-1.elasticbeanstalk.com/api/orders");
    final headers = {
      'Authorization': 'Bearer ${ref.read(tokenProvider)}',
      'Content-Type': 'application/json'};

    final body = jsonEncode(order.toJson());
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        var decodeFormat = utf8.decode(response.bodyBytes);
        final data = jsonDecode(decodeFormat);
        print(data);
      } else {
        print('Failed to post data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  static totalPriceCalculation(
      {GlobalKey<FormState>? formKey,
      VoidCallback? validationform,
      required String textButton,
      bool? paymentSelected,
      Order? rawOrder}) {
    return Consumer(
      builder: (context, ref, child) {
        final totalProductCount = ref
            .watch(cartListNotifierProvider.notifier)
            .getTotalProductAmount();
        final totalProductPrice =
            ref.watch(cartListNotifierProvider.notifier).getTotalProductPrice();
        final totalProductDiscount =
            ref.watch(cartListNotifierProvider.notifier).getTotalDiscount();
        final totalProductDiscountPrice = ref
            .watch(cartListNotifierProvider.notifier)
            .getTotalDiscountPrice();
        final deliveryPrice = ref.watch(deliveryPriceProvider);
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Container(
                        width:
                            Utilities.setWidgetWidthByPercentage(context, 91),
                        height:
                            Utilities.setWidgetHeightByPercentage(context, 3.5),
                        alignment: Alignment.centerLeft,
                        child: const Text("Оплата:",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16)),
                      ),
                      SizedBox(
                        width:
                            Utilities.setWidgetWidthByPercentage(context, 91),
                        height:
                            Utilities.setWidgetHeightByPercentage(context, 2.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Товары ($totalProductCount)_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _",
                                style: const TextStyle(
                                    color: Color.fromRGBO(177, 175, 175, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14)),
                            Text("$totalProductPrice С",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                      SizedBox(
                        width:
                            Utilities.setWidgetWidthByPercentage(context, 91),
                        height:
                            Utilities.setWidgetHeightByPercentage(context, 2.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                                "Размер скидки_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _",
                                style: TextStyle(
                                    color: Color.fromRGBO(177, 175, 175, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14)),
                            Text("-$totalProductDiscount С",
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                      SizedBox(
                        width:
                            Utilities.setWidgetWidthByPercentage(context, 91),
                        height:
                            Utilities.setWidgetHeightByPercentage(context, 2.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                "Доставка _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _",
                                style: TextStyle(
                                    color: Color.fromRGBO(177, 175, 175, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ),
                            Text(
                              "$deliveryPrice",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
              Expanded(
                flex: 2,
                child: Container(
                  width: Utilities.setWidgetWidthByPercentage(context, 91),
                  color: Colors.white,
                  child: Column(children: [
                    Container(
                      height: Utilities.setWidgetHeightByPercentage(context, 3),
                      width: Utilities.setWidgetWidthByPercentage(context, 91),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Общая стоимость",
                            style: TextStyle(
                                color: Color.fromRGBO(98, 175, 28, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          Text("${totalProductDiscountPrice + deliveryPrice} С",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600))
                        ],
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(98, 175, 28, 1),
                            borderRadius: BorderRadius.circular(8)),
                        width:
                            Utilities.setWidgetWidthByPercentage(context, 91),
                        height:
                            Utilities.setWidgetHeightByPercentage(context, 4.7),
                        child: textButton == "Оформить"
                            ? Container(
                                alignment: Alignment.center,
                                child: totalProductCount == 0
                                    ? Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        width: Utilities
                                            .setWidgetWidthByPercentage(
                                                context, 91),
                                        height: Utilities
                                            .setWidgetHeightByPercentage(
                                                context, 4.7),
                                        child: Text(
                                          textButton,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CheckoutPage()));
                                        },
                                        child: Text(
                                          textButton,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        )),
                              )
                            : TextButton(
                                onPressed: () {
                                  if (formKey != null) {
                                    if (formKey.currentState!.validate()) {
                                      if (validationform != null) {
                                        validationform();
                                      }
                                      if (paymentSelected != null) {
                                        if (paymentSelected) {
                                          if (rawOrder != null) {
                                            Order order = Order(
                                                phoneNumber:
                                                    rawOrder.phoneNumber,
                                                totalDiscount:
                                                    totalProductDiscount,
                                                id: rawOrder.id,
                                                deliveryPrice: deliveryPrice,
                                                orderStatus:
                                                    rawOrder.orderStatus,
                                                customerFirstName:
                                                    rawOrder.customerFirstName,
                                                customerLastName:
                                                    rawOrder.customerLastName,
                                                customerAddress:
                                                    rawOrder.customerAddress,
                                                orderedProducts:
                                                    rawOrder.orderedProducts,
                                                totalOrderPrice:
                                                    totalProductDiscountPrice);
                                                    postOrder(order, ref);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReceiptPage(
                                                            ref: ref,
                                                            order: order)));
                                          }
                                          ref
                                              .read(deliveryPriceProvider
                                                  .notifier)
                                              .state = ref
                                                  .read(userProvider)
                                                  .region
                                                  ?.priceDelivery ??
                                              0.0;

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text("Успешно изменено")),
                                          );
                                        }
                                      }
                                    }
                                  }
                                },
                                child: Text(
                                  textButton,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )))
                  ]),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
