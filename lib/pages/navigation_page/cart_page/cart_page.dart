import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/provider/cart_list_provider.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        color: const Color.fromRGBO(255, 255, 255, 1),
        height: Utilities.setWidgetHeightByPercentage(context, 6),
      ),
      Expanded(
        flex: 5,
        child: Container(
            color: const Color.fromRGBO(255, 255, 255, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                const Text(
                  "Корзина",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
        flex: 40,
        child: Consumer(
          builder: (context, ref, child) {
            final List<Product> cartProductList =
                ref.watch(cartListNotifierProvider);
            // for (Product p in cartProductList) {
            //   print(p.name);
            //   print(p.quantity);
            // }
            return ListView.builder(
              itemCount: cartProductList.length,
              itemBuilder: (context, index) {
                var product = cartProductList[index];
                return Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Container(
                      color: Colors.lightGreen,
                            width: Utilities.setWidgetWidthByPercentage(context, 95),
                            height: Utilities.setWidgetHeightByPercentage(context, 16.3),
                            // margin: EdgeInsets.all(16),
                      child: Row(
                        children: [
                            Container(
                              margin: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Image(image: AssetImage(product.picture), fit: BoxFit.cover, width: 100, height: 100,)
                          ),
                          Container(

                          )
                        ],
                      ),
                    )
                    // child: ListTile(

                    //   title: Text(
                    //     product.name,
                    //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    //   ),
                    //   subtitle: Text(
                    //     product.description,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    //   leading:
                    //   trailing: Text(
                    //     '\$${product.price}',
                    //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    //   ),
                    // ),
                    );
              },
            );
          },
        ),
      )
    ]));
  }
}
