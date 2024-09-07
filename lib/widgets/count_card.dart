import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/provider/cart_list_provider.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountCard extends StatefulWidget {
  final WidgetRef ref;
  Product product;
  CountCard({super.key, required this.ref, required this.product});

  @override
  State<CountCard> createState() => _CountCardState();
}

class _CountCardState extends State<CountCard> {
  @override
  Widget build(BuildContext context) {
    int counter = widget.ref
        .watch(cartListNotifierProvider.notifier)
        .productFinalCount(widget.product);
    CartListNotifier cartController =
        widget.ref.watch(cartListNotifierProvider.notifier);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        height: Utilities.setWidgetHeightByPercentage(context, 4.3),
        width: Utilities.setWidgetWidthByPercentage(context, 39.2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(230, 234, 237, 1),
                  shape: BoxShape.circle),
              child: InkWell(
                child: const Icon(Icons.remove, color: Color.fromRGBO(151, 152, 153, 1),),
                onTap: () {
                  cartController.countDecrement(widget.product);
                },
              ),
            ),
            Text("$counter шт"),
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(98, 175, 28, 1),
                  shape: BoxShape.circle),
              child: InkWell(
                child: const Icon(Icons.add, color: Colors.white,),
                onTap: () {
                  cartController.countIncrement(widget.product);
                },
              ),
            )
          ],
        ));
  }
}
