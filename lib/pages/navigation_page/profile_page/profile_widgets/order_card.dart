// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dinde_market/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dinde_market/models/order.dart';
import 'package:dinde_market/utility/utilities.dart';

class OrderCard extends ConsumerStatefulWidget {
  final Order order;
  const OrderCard(this.order, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderCardState();
}

class _OrderCardState extends ConsumerState<OrderCard> {
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    bool statusCompleted =
        widget.order.getOrderDateTime(OrderStatus.completed) != "";
    bool statusUnderReview =
        widget.order.getOrderDateTime(OrderStatus.underReview) != "";
    bool statusAccepted =
        widget.order.getOrderDateTime(OrderStatus.accepted) != "";
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ]
      ),
      width: Utilities.setWidgetWidthByPercentage(context, 91.5),
      height: Utilities.setWidgetHeightByPercentage(context, 69.2),
      margin: const EdgeInsets.only(bottom: 35),
      child: Column(
        children: [
          Expanded(
            flex: 86,
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Colors.white,
      ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        width:
                            Utilities.setWidgetWidthByPercentage(context, 20.3),
                        height:
                            Utilities.setWidgetHeightByPercentage(context, 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(228, 238, 252, 1),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "№${widget.order.orderNumber}",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                          // flex: 3,
                          child: statusUnderReview
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromRGBO(98, 175, 28, 1)),
                                      child: const Text(
                                        "1",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromRGBO(166, 166, 166, 1)),
                                      child: const Text(
                                        "1",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )),
                      statusAccepted
                          ? dashedLine(const Color.fromRGBO(98, 175, 28, 1))
                          : dashedLine(const Color.fromRGBO(166, 166, 166, 1)),
                      Container(
                          child: statusAccepted
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromRGBO(98, 175, 28, 1)),
                                      child: const Text(
                                        "2",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.zero,
                                      width: 20,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromRGBO(166, 166, 166, 1)),
                                      child: const Text(
                                        "2",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )),
                      statusCompleted
                          ? dashedLine(const Color.fromRGBO(98, 175, 28, 1))
                          : dashedLine(const Color.fromRGBO(166, 166, 166, 1)),
                      Container(
                          // flex: 3,
                          padding: const EdgeInsets.only(right: 10),
                          child: statusCompleted
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.zero,
                                      width: 20,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromRGBO(98, 175, 28, 1)),
                                      child: const Text(
                                        "3",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromRGBO(166, 166, 166, 1)),
                                      child: const Text(
                                        "3",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: Utilities.setWidgetWidthByPercentage(context, 24),
                        right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        statusUnderReview
                            ? Column(
                                children: [
                                  const Text(
                                    "В обработке",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(98, 175, 28, 1)),
                                  ),
                                  Text(
                                    widget.order.getOrderDateTime(
                                        OrderStatus.underReview),
                                    style: const TextStyle(
                                        color: Color.fromRGBO(98, 175, 28, 1),
                                        fontSize: 8,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            : const Column(
                                children: [
                                  Text(
                                    "В обработке",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromRGBO(166, 166, 166, 1)),
                                  ),
                                  Text(
                                    "----",
                                    style: TextStyle(
                                        color: Color.fromRGBO(166, 166, 166, 1),
                                        fontSize: 8,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                        statusAccepted
                            ? Column(
                                children: [
                                  const Text(
                                    "Принят",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(98, 175, 28, 1)),
                                  ),
                                  Text(
                                    widget.order
                                        .getOrderDateTime(OrderStatus.accepted),
                                    style: const TextStyle(
                                        color: Color.fromRGBO(98, 175, 28, 1),
                                        fontSize: 8,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            : const Column(
                                children: [
                                  Text(
                                    "Принят",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromRGBO(166, 166, 166, 1)),
                                  ),
                                  Text(
                                    "----",
                                    style: TextStyle(
                                        color: Color.fromRGBO(166, 166, 166, 1),
                                        fontSize: 8,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                        statusCompleted
                            ? Column(
                                children: [
                                  const Text(
                                    "Завершен",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(98, 175, 28, 1)),
                                  ),
                                  Text(
                                    widget.order.getOrderDateTime(
                                        OrderStatus.completed),
                                    style: const TextStyle(
                                        color: Color.fromRGBO(98, 175, 28, 1),
                                        fontSize: 8,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            : const Column(
                                children: [
                                  Text(
                                    "Завершен",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromRGBO(166, 166, 166, 1)),
                                  ),
                                  Text(
                                    "----",
                                    style: TextStyle(
                                        color: Color.fromRGBO(166, 166, 166, 1),
                                        fontSize: 8,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 13),
              child: const Divider(color: Color.fromRGBO(232, 239, 249, 1), height: 3,),
            )
          ),
          Expanded(
            flex: 116,
            child: Container(
              color: Colors.white
              ,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.my_location_outlined, color: Colors.orange,),
                        dashedLine(const Color.fromRGBO(166, 166, 166, 1), isHorizontal: false),
                        const Icon(Icons.location_on_outlined, color: Colors.green,)
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(widget.order.marketName, style: const TextStyle(color: Color.fromRGBO(166, 166, 166, 1), fontSize: 14, fontWeight: FontWeight.w500),),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.order.customerName, style: const TextStyle(color: Color.fromRGBO(166, 166, 166, 1), fontSize: 14, fontWeight: FontWeight.w500),),
                      Text("г. ${widget.order.customerAddress.city}, ул. ${widget.order.customerAddress.street}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                      Text("Квартира ${widget.order.customerAddress.unit}, Подъезд ${widget.order.customerAddress.entrance}, Этаж ${widget.order.customerAddress.floor}", style: const TextStyle( fontSize: 11, fontWeight: FontWeight.w500),)
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 110,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 3, top: 12),
                    alignment: Alignment.topLeft,
                    child: const Text("Комментарий:"),
                  ),
                  Container(
                    width: Utilities.setWidgetWidthByPercentage(context, 87.2),
                    height: Utilities.setWidgetHeightByPercentage(context, 8.6),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color.fromRGBO(228, 238, 252, 1), width: 1),
                      borderRadius: BorderRadius.circular(11)
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(widget.order.customerAddress.customerCommments),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 117,
            child: Container(
              color: Colors.white,
              child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.order.orderedProducts.length,
                itemBuilder: (context, index) {
                  var product = widget.order.orderedProducts[index];
                  return orderedProductCard(product, context);
                },
              ),
              ),
            ),
          ),
          Expanded(
            flex: 63,
            child: Container(
              color: Colors.white,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
      color: const Color.fromRGBO(117, 203, 39, 0.1),
      border: Border.all(color: const Color.fromRGBO(117, 203, 39, 0.5), width: 1),
      borderRadius: BorderRadius.circular(11)
    ),
                child: Text("Итого к оплате: ${widget.order.totalOrderPrice} сом", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
              ),
            ),
          ),
          Expanded(
            flex: 70,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8)
                ),
                alignment: Alignment.center,
                child: TextButton(
                  child: const Text("Отменить заказ", style: TextStyle(color: Colors.white),),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget dashedLine(Color color, {bool isHorizontal = true}) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0), // Optional margin
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Flex(
            direction: isHorizontal ? Axis.horizontal : Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              ((isHorizontal
                      ? constraints.constrainWidth() 
                      : constraints.constrainHeight()) /
                  10.floor()).toInt(),
              (index) {
                return SizedBox(
                  width: isHorizontal ? 4 : 1, // Width of each dash (for horizontal)
                  height: isHorizontal ? 1 : 6, // Height of each dash (for vertical)
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: color), // Color of the dashes
                  ),
                );
              },
            ),
          );
        },
      ),
    ),
  );
}

Widget orderedProductCard(Product product, BuildContext context) {
  return Container(
    width: Utilities.setWidgetWidthByPercentage(context, 66),
    height: Utilities.setWidgetHeightByPercentage(context, 11.1),
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),

    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color.fromRGBO(228, 238, 252, 1), width: 1),
      borderRadius: BorderRadius.circular(11)
    ),
    child: Row(
      children: [
        Container(
          width: 130,
          height: 90,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Image(image: AssetImage(product.picture),)
        ),
        SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Товар: ${product.subCategory.name}", overflow: TextOverflow.fade,),
              Text("Количество: ${product.count}"),
              Text("Цена: ${product.price}")
            ],
          ),
        )
      ],
    ),
  );
}