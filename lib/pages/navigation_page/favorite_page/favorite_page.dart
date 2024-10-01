import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/pages/error_page/empty_page.dart';
import 'package:dinde_market/provider/favorite_list_provider.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:dinde_market/widgets/product_card_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _CartPageState();
}

class _CartPageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        color: const Color.fromRGBO(255, 255, 255, 1),
        height: Utilities.setWidgetHeightByPercentage(context, 6),
      ),
      Container(
          height: Utilities.setWidgetHeightByPercentage(context, 5.2),
          color: const Color.fromRGBO(255, 255, 255, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(),
              const Text(
                "Избранное",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          )),
      Expanded(
        child: Container(
            alignment: Alignment.topCenter,
            child: Consumer(
              builder: (context, ref, child) {
                final List<Product> localFavoriteList =
                    ref.watch(favoriteListNotifierProvider);
                var reversedList = localFavoriteList.reversed.toList();
                return localFavoriteList.isNotEmpty
                    ? ProductCardLayout.productCardLayout(
                        productList: reversedList)
                    : EmptyPage.emptyPage(
                        ref: ref,
                        context: context,
                        firstText: "Здесь пока ничего нет",
                        secondText:
                            "Здесь появятся товары, добавленные в избранное",
                        thirdText: "Начать покупки");
              },
            )),
      )
    ]));
  }
}
