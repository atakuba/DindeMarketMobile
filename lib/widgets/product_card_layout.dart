import 'package:flutter/material.dart';
import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/widgets/product_card.dart';

class ProductCardLayout {
  static Widget productCardLayout({required List<Product> productList}) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (100 / 150),
        crossAxisSpacing: 1,
        mainAxisSpacing: 3,
      ),
      scrollDirection: Axis.vertical,
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return ProductCard(product: productList[index]);
      },
    );
  }
}
