import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/pages/navigation_page/home_page/product_page.dart';
import 'package:dinde_market/provider/cart_list_provider.dart';
import 'package:dinde_market/provider/favorite_list_provider.dart';
import 'package:dinde_market/provider/products_provider.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:dinde_market/widgets/count_card.dart';

class ProductCard extends ConsumerWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updatedProductd = ref.watch(productListProvider).firstWhere((p) => p.id == product.id);
    final isFavorite = ref
        .watch(productListProvider)
        .where((p) => p.id == product.id)
        .first
        .favorite;
    final isInCart =
        ref.watch(cartListNotifierProvider.notifier).notInCart(product);
    return Container(
      margin: const EdgeInsets.all(9),
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              SizedBox(
                child: InkWell(
                  child: Image.network(updatedProductd.photos.first.url,
                      errorBuilder: (context, error, stackTrace) {
                    return const Text(
                      'Ошибка загрузки изображения',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red,
                          decoration: TextDecoration.underline,
                          fontSize: 12),
                    );
                  },
                  height: Utilities.setWidgetHeightByPercentage(context, 18),
                      ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductPage(product: product),
                    ));
                  },
                ),
              ),
              Positioned(
                  left: 0,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        product.discount != 0
                            ? Container(
                                width: Utilities.setWidgetWidthByPercentage(
                                    context, 13),
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 3.3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.red,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "-${product.discount}%",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  )),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                height: Utilities.setWidgetHeightByPercentage(context, 3.94),
                width: Utilities.setWidgetWidthByPercentage(context, 8.5),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: InkWell(
                  child: Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: Colors.red,
                  ),
                  onTap: () {
                    ref
                        .read(favoriteListNotifierProvider.notifier)
                        .toggleFavorite(updatedProductd);
                  },
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: Utilities.setWidgetHeightByPercentage(context, 2.5),
            margin: EdgeInsets.only(
              left: Utilities.setWidgetWidthByPercentage(context, 3),
              top: 6,
            ),
            child: Text(
              '${product.price.round()} с/шт',
              style: const TextStyle(color: Color.fromRGBO(98, 175, 28, 1)),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              horizontal: Utilities.setWidgetWidthByPercentage(context, 3),
              vertical: 4,
            ),
            height: Utilities.setWidgetHeightByPercentage(context, 2),
            child: Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
            ),
          ),
          Container(
              alignment: Alignment.center,
              height: Utilities.setWidgetHeightByPercentage(context, 4.1),
              width: Utilities.setWidgetWidthByPercentage(context, 39.2),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(98, 175, 28, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: isInCart
                  ? SizedBox(
                      height:
                          Utilities.setWidgetHeightByPercentage(context, 3.9),
                      width:
                          Utilities.setWidgetWidthByPercentage(context, 39.2),
                      child: TextButton(
                        child: const Text(
                          "В корзину",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          ref
                              .read(cartListNotifierProvider.notifier)
                              .amountIncrement(product);
                        },
                      ),
                    )
                  : CountCard(
                      product: product,
                    )),
        ],
      ),
    );
  }
}
