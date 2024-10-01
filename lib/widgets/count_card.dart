import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/provider/cart_list_provider.dart';
import 'package:dinde_market/utility/utilities.dart';

class CountCard extends ConsumerStatefulWidget {
  final Product product;
  const CountCard({super.key, required this.product});

  @override
  ConsumerState<CountCard> createState() => _CountCardState();
}

class _CountCardState extends ConsumerState<CountCard> {
  @override
  void initState() {
    super.initState();
    ref.read(cartListNotifierProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    CartListNotifier cartController =
        ref.watch(cartListNotifierProvider.notifier);
    int counter = ref
        .watch(cartListNotifierProvider.notifier)
        .productFinalAmount(widget.product);
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
              child: const Icon(Icons.remove,
                  color: Color.fromRGBO(151, 152, 153, 1)),
              onTap: () {
                cartController.amountDecrement(widget.product, counter);
              },
            ),
          ),
          Text("$counter шт"),
          Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(98, 175, 28, 1), shape: BoxShape.circle),
            child: InkWell(
              child: const Icon(Icons.add, color: Colors.white),
              onTap: () {
                cartController.amountIncrement(widget.product);
              },
            ),
          )
        ],
      ),
    );
  }
}
