import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dinde_market/models/order.dart';
import 'package:dinde_market/pages/navigation_bar_page.dart';
import 'package:dinde_market/provider/buttom_nav_bar_provider.dart';
import 'package:dinde_market/utility/utilities.dart';

class ReceiptPage extends StatefulWidget {
  final Order order;
  final WidgetRef ref;
  const ReceiptPage({super.key, required this.order, required this.ref});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(232, 239, 249, 1),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              height: Utilities.setWidgetHeightByPercentage(context, 6),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        height:
                            Utilities.setWidgetHeightByPercentage(context, 20),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.check_circle_rounded,
                              color: Color.fromRGBO(98, 175, 28, 1),
                              size: 55,
                            ),
                            const Text(
                              "Заказ оформлен",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            Text(
                              "${widget.order.totalOrderPrice} C",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Дата",
                          style: TextStyle(
                              color: Color.fromRGBO(135, 146, 155, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(widget.order.getOrderDate(OrderStatus.underReview),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Имя:",
                          style: TextStyle(
                              color: Color.fromRGBO(135, 146, 155, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(widget.order.customerFirstName,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Фамилия:",
                          style: TextStyle(
                              color: Color.fromRGBO(135, 146, 155, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(widget.order.customerLastName,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Номер:",
                          style: TextStyle(
                              color: Color.fromRGBO(135, 146, 155, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(widget.order.id.toString(),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Регион:",
                          style: TextStyle(
                              color: Color.fromRGBO(135, 146, 155, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(widget.order.customerAddress.city,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Адрес:",
                          style: TextStyle(
                              color: Color.fromRGBO(135, 146, 155, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(widget.order.customerAddress.street,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                  ),
                  Container(
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 15),
                        child: const Divider(
                          color: Color.fromRGBO(232, 239, 249, 1),
                          height: 3,
                        ),
                      )),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Товар(${widget.order.orderedProducts.length}):",
                          style: const TextStyle(
                              color: Color.fromRGBO(135, 146, 155, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text("${widget.order.totalOrderPrice}",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Размер скидки:",
                          style: TextStyle(
                              color: Color.fromRGBO(135, 146, 155, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text("-${widget.order.totalDiscount}",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.red))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Доставка:",
                          style: TextStyle(
                              color: Color.fromRGBO(135, 146, 155, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text("eto dostavka",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))
                      ],
                    ),
                  ),
                  Container(
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 15),
                        child: const Divider(
                          color: Color.fromRGBO(232, 239, 249, 1),
                          height: 3,
                        ),
                      )),
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Общая стоимость:",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${widget.order.totalOrderPrice} C",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: Utilities.setWidgetHeightByPercentage(context, 8),
              child: Text(
                "Вы можете отследить заказ в личном кабинете.\nЧерез некоторое время с вами свяжутся для уточнения деталей.",
                overflow: TextOverflow.visible,
                style: const TextStyle(
                    color: Color.fromRGBO(135, 146, 155, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ),
            GestureDetector(
              child: Container(
                width: Utilities.setWidgetWidthByPercentage(context, 90),
                height: Utilities.setWidgetHeightByPercentage(context, 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromRGBO(98, 175, 28, 1)),
                child: const Text(
                  "Открыть мои заказы",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              onTap: () {
                widget.ref.read(selectedIndexProvider.notifier).state = 3;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NavigationBarPage()));
              },
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                width: Utilities.setWidgetWidthByPercentage(context, 90),
                height: Utilities.setWidgetHeightByPercentage(context, 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        width: 1, color: const Color.fromRGBO(98, 175, 28, 1))),
                child: const Text(
                  "Продолжить покупки",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              onTap: () {
                widget.ref.read(selectedIndexProvider.notifier).state = 0;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NavigationBarPage()));
              },
            )
          ],
        ));
  }
}
