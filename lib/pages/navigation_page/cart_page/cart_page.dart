import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/pages/error_page/empty_page.dart';
import 'package:dinde_market/pages/navigation_page/cart_page/total_price_widget.dart';
import 'package:dinde_market/provider/cart_list_provider.dart';
import 'package:dinde_market/provider/favorite_list_provider.dart';
import 'package:dinde_market/provider/products_provider.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:dinde_market/widgets/count_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(244, 245, 249, 1),
        body: Column(children: [
          Container(
            color: const Color.fromRGBO(255, 255, 255, 1),
            height: Utilities.setWidgetHeightByPercentage(context, 6),
          ),
          Expanded(
            flex: 3,
            child: Container(
                color: const Color.fromRGBO(255, 255, 255, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(),
                    const Text(
                      "Корзина",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                )),
          ),
          Expanded(
            flex: 3,
            child: Container(
                alignment: Alignment.centerRight,
                child: Consumer(
                  builder: (context, ref, child) {
                    final List<Product> cartProductList =
                        ref.watch(productListProvider);
                    return TextButton(
                      child: const Text(
                        "Очистить",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        ref
                            .read(cartListNotifierProvider.notifier)
                            .removeAllProductsFromCart(cartProductList);
                      },
                    );
                  },
                )),
          ),
          Expanded(
            flex: 40,
            child: Consumer(
              builder: (context, ref, child) {
                final List<Product> cartProductList =
                    ref.watch(cartListNotifierProvider);
                return cartProductList.isEmpty
                    ? EmptyPage.emptyPage(
                        context: context,
                        firstText: "Ваша корзина пуста",
                        secondText:
                            "Добавьте товары из каталога, чтобы сделать заказ!",
                        thirdText: "Перейти в каталог",
                        ref: ref)
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: cartProductList.length,
                        itemBuilder: (context, index) {
                          var product = cartProductList[index];
                          final isFavorite = ref
                              .watch(favoriteListNotifierProvider.notifier)
                              .isFavorite(product);
                          CartListNotifier cartController =
                              ref.watch(cartListNotifierProvider.notifier);
                          return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 3,
                                        blurRadius: 5,
                                        offset: const Offset(0, 0),
                                      )
                                    ]),
                                width: Utilities.setWidgetWidthByPercentage(
                                    context, 95),
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 16.3),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                          margin: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Stack(
                                            children: [
                                              Image.network(
                                                product.photos.first.url,
                                                fit: BoxFit.cover,
                                                width: 100,
                                                height: 100,
                                              ),
                                              Positioned(
                                                left: 0,
                                                child: product.discount != 0
                                                    ? Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 5),
                                                        width: Utilities
                                                            .setWidgetWidthByPercentage(
                                                                context, 10),
                                                        height: Utilities
                                                            .setWidgetHeightByPercentage(
                                                                context, 2.5),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: Colors.red,
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "-${product.discount}%",
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      )
                                                    : Container(),
                                              )
                                            ],
                                          )),
                                    ),
                                    Expanded(
                                        flex: 7,
                                        child: Container(
                                          margin: const EdgeInsets.all(16),
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${product.price.round()} с/шт",
                                                      style: const TextStyle(
                                                          color: Color.fromRGBO(
                                                              104, 175, 28, 1),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 14),
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      product.name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12),
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: CountCard(
                                                          product: product)))
                                            ],
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: InkWell(
                                                  child: isFavorite
                                                      ? const Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                        )
                                                      : const Icon(
                                                          Icons
                                                              .favorite_border_outlined,
                                                          color: Color.fromRGBO(
                                                              138, 138, 142, 1),
                                                        ),
                                                  onTap: () {
                                                    ref
                                                        .read(
                                                            favoriteListNotifierProvider
                                                                .notifier)
                                                        .toggleFavorite(
                                                            product);
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: InkWell(
                                                    child: const Icon(
                                                      Icons.delete_outlined,
                                                      color: Color.fromRGBO(
                                                          138, 138, 142, 1),
                                                    ),
                                                    onTap: () {
                                                      cartController
                                                          .removeProductFromCart(
                                                              product);
                                                    },
                                                  ))
                                            ]))
                                  ],
                                ),
                              ));
                        },
                      );
              },
            ),
          ),
          Expanded(
              flex: 15,
              child: TotalPriceWidget.totalPriceCalculation(
                  isCashPaymentSelected: false,
                  isOnlinePaymentSelected: false,
                  textButton: "Оформить"))
        ]));
  }
}

int totalProductCost(List<Product> products) {
  int totalCost = 0;
  for (Product p in products) {
    //Needs to be changed to double
    totalCost += p.price.round();
  }
  return totalCost;
}
