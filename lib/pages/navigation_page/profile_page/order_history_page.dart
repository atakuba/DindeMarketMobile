import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dinde_market/models/order.dart';
import 'package:dinde_market/pages/navigation_page/profile_page/profile_widgets/order_card.dart';
import 'package:dinde_market/provider/order_provider.dart';
import 'package:dinde_market/utility/utilities.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int orderNumber = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("История заказов"),
        centerTitle: true,
        bottom: TabBar(
          onTap: (index) {
            if (index == 1) {
              setState(() {
                orderNumber = 0;
              });
            }
          },
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.green,
          labelColor: Colors.black,
          unselectedLabelColor: const Color.fromRGBO(166, 166, 166, 1),
          controller: controller,
          tabs: const [
            Tab(
              text: "Текущие",
            ),
            Tab(
              text: "История",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          Container(
            color: const Color.fromRGBO(244, 245, 249, 1),
            child: Consumer(
              builder: (context, ref, child) {
                final orderList = ref
                    .watch(orderProvider)
                    .where(
                        (p) => p.getOrderDateTime(OrderStatus.completed) == "")
                    .toList();
                return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    physics: const BouncingScrollPhysics(),
                    itemCount: orderList.length,
                    itemBuilder: (context, index) {
                      var order = orderList[index];
                      return OrderCard(order);
                    });
              },
            ),
          ),
          Container(
              color: const Color.fromRGBO(244, 245, 249, 1),
              child: Consumer(
                builder: (contex, ref, child) {
                  final orderList = ref
                      .watch(orderProvider)
                      .where((p) =>
                          p.getOrderDateTime(OrderStatus.completed) != "")
                      .toList();
                  return orderNumber == 0
                      ? ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          itemCount: orderList.length,
                          itemBuilder: (context, index) {
                            var order = orderList[index];
                            return InkWell(
                              child: Container(
                                width: Utilities.setWidgetWidthByPercentage(
                                    context, 95),
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 8),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            98, 175, 28, 0.6)),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Покупка на сумму:"),
                                        Text(
                                          "${order.totalOrderPrice} c",
                                          style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  98, 175, 28, 1),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(order.getOrderDateTime(
                                            OrderStatus.completed)),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color:
                                              Color.fromRGBO(138, 138, 142, 1),
                                          size: 15,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  orderNumber = order.orderNumber;
                                });
                              },
                            );
                          },
                        )
                      : Container(
                          padding: const EdgeInsets.all(12),
                          child: OrderCard(ref
                              .watch(orderProvider.notifier)
                              .state
                              .firstWhere((o) => o.orderNumber == orderNumber)),
                        );
                },
              ))
        ],
      ),
    );
  }
}
