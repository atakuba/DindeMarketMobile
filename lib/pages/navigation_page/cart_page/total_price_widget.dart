import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dinde_market/models/order.dart';
import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/models/product_photo.dart';
import 'package:dinde_market/pages/navigation_page/cart_page/checkout_page.dart';
import 'package:dinde_market/pages/navigation_page/cart_page/receipt_page.dart';
import 'package:dinde_market/provider/cart_list_provider.dart';
import 'package:dinde_market/utility/utilities.dart';

class TotalPriceWidget {
  static totalPriceCalculation(
      {GlobalKey<FormState>? formKey,
      VoidCallback? validationform,
      required String textButton,
      bool? paymentSelected}) {
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
        Order order = Order(
            receiptMessage:
                "Вы можете отследить заказ в личном кабинете.\nЧерез некоторое время с вами свяжутся для уточнения деталей.  ",
            totalDiscount: 999,
            id: 4,
            orderNumber: 999,
            orderStatus: {OrderStatus.underReview: DateTime.now()},
            marketName: "Dinde Market",
            customerName: "Erbol",
            customerAddress: CustomerAddress(
                id: 4,
                city: "Karakol",
                street: "kokulov",
                customerCommments: "Leave at my porch"),
            orderedProducts: [
              Product(
                  // seasonal: true,
                  // newProduct: true,
                  discount: 50,
                  favorite: true,
                  count: 0,
                  id: 16,
                  releaseDate: DateTime.now(),
                  name: "aКефир отборный Коровка",
                  photos: [
                    ProductPhoto(id: 1, url: "assets/offers/sales_pic.png")
                  ],
                  price: 1000.0,
                  description:
                      "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. ",
                  subCategoryId: 1)
            ],
            totalOrderPrice: 6000,
            orderDate: DateTime.now());
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Доставка _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _",
                                style: TextStyle(
                                    color: Color.fromRGBO(177, 175, 175, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ),
                            Text(
                              "55555 С",
                              style: TextStyle(
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
                          Text("$totalProductDiscountPrice С",
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
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReceiptPage(
                                                          ref: ref,
                                                          order: order)));
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
