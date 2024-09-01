import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(244, 245, 249, 1),
        body: Column(
          children: [
            Container(
              color: const Color.fromRGBO(255, 255, 255, 1),
              height: Utilities.setWidgetHeightByPercentage(context, 6),
            ),
            Expanded(
              flex: 42,
              child: Container(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.arrow_back_ios_outlined),
                      ),
                      const Text(
                        "Товар",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Utilities.setWidgetWidthByPercentage(
                                context, 4)),
                        child: const Icon(Icons.favorite_border_outlined),
                      ),
                    ],
                  )),
            ),
            Expanded(
              flex: 250,
              child: SizedBox(
                height: Utilities.setWidgetHeightByPercentage(context, 37),
                width: Utilities.setWidgetWidthByPercentage(context, 80),
                child: Image(
                  image: AssetImage(product.picture),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              flex: 247,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        Utilities.setWidgetWidthByPercentage(context, 4.3)),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${product.price} с/шт',
                        style: const TextStyle(
                            color: Color.fromRGBO(98, 175, 28, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        product.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(bottom: 8),
                      child: const Text(
                        'Описание товара',
                        style: TextStyle(
                            color: Color.fromRGBO(138, 138, 142, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Text(
                        product.description,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(77, 77, 80, 1)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: Utilities.setWidgetWidthByPercentage(context, 95),
                      height: Utilities.setWidgetHeightByPercentage(context, 5),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(98, 175, 28, 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextButton(
                        child: const Text(
                          "В корзину",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
