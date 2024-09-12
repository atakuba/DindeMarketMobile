import 'package:dinde_market/pages/navigation_page/cart_page/total_price_widget.dart';
import 'package:dinde_market/pages/opening_pages/district_modal_widget.dart';
import 'package:dinde_market/provider/district_provider.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  var selectedDistrict = "Выберите регион";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(244, 245, 249, 1),
        appBar: AppBar(
          title: const Text("Заказать"),
          centerTitle: true,
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final List<String> districtList =
                ref.read(districtProvider.notifier).state.toList();
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 7),
                          color: Colors.white,
                          height: Utilities.setWidgetHeightByPercentage(
                              context, 23),
                          child: Column(
                            children: [
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "Личные данные",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                width: Utilities.setWidgetWidthByPercentage(
                                    context, 95),
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 5.2),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Имя",
                                    hintStyle: const TextStyle(
                                        color: Color.fromRGBO(135, 146, 155, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(185, 212, 191, 1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(185, 212, 191, 1),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                width: Utilities.setWidgetWidthByPercentage(
                                    context, 95),
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 5.2),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Фамилия",
                                    hintStyle: const TextStyle(
                                        color: Color.fromRGBO(135, 146, 155, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(185, 212, 191, 1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(185, 212, 191, 1),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                width: Utilities.setWidgetWidthByPercentage(
                                    context, 95),
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 5.2),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "+996 ( ___ ) __ __ __",
                                    hintStyle: const TextStyle(
                                        color: Color.fromRGBO(135, 146, 155, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(185, 212, 191, 1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(185, 212, 191, 1),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          color: Colors.white,
                          height: Utilities.setWidgetHeightByPercentage(
                              context, 40),
                          child: Column(
                            children: [
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "Куда доставить?",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                width: Utilities.setWidgetWidthByPercentage(
                                    context, 90),
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      side: const BorderSide(
                                          color:
                                              Color.fromRGBO(177, 207, 183, 1),
                                          width: 1.0),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                    ),
                                    child: Text(
                                      selectedDistrict,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(),
                                    ),
                                    onPressed: () async {
                                      final newDistrict = await DistrictModal
                                          .districtModalWidget(
                                              context: context,
                                              districtList: districtList);
                                      setState(() {
                                        selectedDistrict = newDistrict;
                                      });
                                    }),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                width: Utilities.setWidgetWidthByPercentage(
                                    context, 95),
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 5.2),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Улица",
                                    hintStyle: const TextStyle(
                                        color: Color.fromRGBO(135, 146, 155, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(185, 212, 191, 1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(185, 212, 191, 1),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      width:
                                          Utilities.setWidgetWidthByPercentage(
                                              context, 28),
                                      height:
                                          Utilities.setWidgetHeightByPercentage(
                                              context, 5.2),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: "Квартира",
                                          hintStyle: const TextStyle(
                                              color: Color.fromRGBO(
                                                  135, 146, 155, 1),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromRGBO(
                                                  185, 212, 191, 1),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  185, 212, 191, 1),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      width:
                                          Utilities.setWidgetWidthByPercentage(
                                              context, 28),
                                      height:
                                          Utilities.setWidgetHeightByPercentage(
                                              context, 5.2),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: "Подъезд",
                                          hintStyle: const TextStyle(
                                              color: Color.fromRGBO(
                                                  135, 146, 155, 1),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromRGBO(
                                                  185, 212, 191, 1),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  185, 212, 191, 1),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      width:
                                          Utilities.setWidgetWidthByPercentage(
                                              context, 28),
                                      height:
                                          Utilities.setWidgetHeightByPercentage(
                                              context, 5.2),
                                      child: TextField(
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                          hintText: "Этаж",
                                          hintStyle: const TextStyle(
                                              color: Color.fromRGBO(
                                                  135, 146, 155, 1),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromRGBO(
                                                  185, 212, 191, 1),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  185, 212, 191, 1),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                width: Utilities.setWidgetWidthByPercentage(
                                    context, 95),
                                child: TextField(
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: Utilities
                                            .setWidgetHeightByPercentage(
                                          context,
                                          7,
                                        ),
                                        horizontal: 15),
                                    hintText: "Комментарий к заказу",
                                    hintStyle: const TextStyle(
                                        color: Color.fromRGBO(135, 146, 155, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(185, 212, 191, 1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(185, 212, 191, 1),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          color: Colors.white,
                          height: Utilities.setWidgetHeightByPercentage(
                              context, 18),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Способ оплаты",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1,
                                          color: const Color.fromRGBO(
                                              177, 207, 183, 1))),
                                  width: Utilities.setWidgetWidthByPercentage(
                                      context, 95),
                                  height: Utilities.setWidgetHeightByPercentage(
                                      context, 8),
                                  child: TextButton(
                                    child: const Text(
                                      "Оплата \nонлайн",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onPressed: () {},
                                  )),
                            ],
                          )),
                    ],
                  ),
                ),
                SizedBox(
                    height: Utilities.setWidgetHeightByPercentage(context, 30),
                    child: TotalPriceWidget.totalPriceCalculation(
                        textButton: "Заказать"))
              ],
            );
          },
        ));
  }
}
