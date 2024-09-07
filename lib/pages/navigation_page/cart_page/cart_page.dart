import 'package:dinde_market/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/provider/cart_list_provider.dart';
import 'package:dinde_market/provider/favorite_list_provider.dart';
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    const Text(
                      "Корзина",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              Utilities.setWidgetWidthByPercentage(context, 4)),
                      child: const Icon(Icons.search_outlined),
                    ),
                  ],
                )),
          ),
          Expanded(
            flex: 3,
            child: Container(
                // color: Colors.amber,
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
                return ListView.builder(
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
                          width:
                              Utilities.setWidgetWidthByPercentage(context, 95),
                          height: Utilities.setWidgetHeightByPercentage(
                              context, 16.3),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                    margin: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        // color: Colors.lightBlue,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Image(
                                      image: AssetImage(product.picture),
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    )),
                              ),
                              Expanded(
                                  flex: 7,
                                  child: Container(
                                    margin: const EdgeInsets.all(16),
                                    alignment: Alignment.centerLeft,
                                    // color: Colors.pink,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "${product.price.round()} с/шт",
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        104, 175, 28, 1),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                product.name,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                            )),
                                        Expanded(
                                            flex: 3,
                                            child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: CountCard(
                                                    ref: ref,
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
                                          padding: const EdgeInsets.all(5),
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
                                                  .toggleFavorite(product);
                                            },
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(5),
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
            child: Consumer(
              builder: (context, ref, child) {
                // final cartProductList = ref.watch(cartListNotifierProvider.notifier).toString();
                final totalProductCount = ref.watch(cartListNotifierProvider.notifier).getTotalProductCount();
                final totalProductPrice = ref.watch(cartListNotifierProvider.notifier).getTotalProductPrice();
                final totalProductDiscount = ref.watch(cartListNotifierProvider.notifier).getTotalDiscount();
                final totalProductDiscountPrice = ref.watch(cartListNotifierProvider.notifier).getTotalDiscountPrice();
                return Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      // color: Colors.pink,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Container(
                                width: Utilities.setWidgetWidthByPercentage(
                                    context, 91),
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 3.5),
                                alignment: Alignment.centerLeft,
                                child: const Text("Оплата:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16)),
                              ),
                              SizedBox(
                                width: Utilities.setWidgetWidthByPercentage(
                                    context, 91),
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 2.5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "Товары (${totalProductCount})_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _",
                                        style: const TextStyle(
                                            color: Color.fromRGBO(
                                                177, 175, 175, 1),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)),
                                    Text("$totalProductPrice С", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: Utilities.setWidgetWidthByPercentage(
                                    context, 91),
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 2.5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                        "Размер скидки_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _",
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                177, 175, 175, 1),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)),
                                    Text("-$totalProductDiscount С", style: const TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w500))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: Utilities.setWidgetWidthByPercentage(
                                    context, 91),
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 2.5),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Доставка _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _",
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                177, 175, 175, 1),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Text("55555 С", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)
                                  ],
                                ),
                              )
                            ],
                          )),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width:
                              Utilities.setWidgetWidthByPercentage(context, 91),
                          color: Colors.white,
                          child: Column(children: [
                            Container(
                              height: Utilities.setWidgetHeightByPercentage(
                                  context, 3),
                              width: Utilities.setWidgetWidthByPercentage(
                                  context, 91),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Общая стоимость",
                                    style: TextStyle(
                                        color: Color.fromRGBO(98, 175, 28, 1),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                  Text("$totalProductDiscountPrice С", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                                ],
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(98, 175, 28, 1),
                                    borderRadius: BorderRadius.circular(8)),
                                width: Utilities.setWidgetWidthByPercentage(
                                    context, 91),
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 4.7),
                                child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Оформить",
                                      style: TextStyle(
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
            ),
          )
        ]));
  }
}
int totalProductCost(List<Product> products) {
  int totalCost = 0;
  for(Product p in products) {
    //Needs to be changed to double
    totalCost += p.price.round();
  }
  return totalCost;
}