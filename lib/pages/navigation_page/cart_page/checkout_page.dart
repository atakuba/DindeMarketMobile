import 'dart:convert';

import 'package:dinde_market/models/order.dart';
import 'package:dinde_market/provider/cart_list_provider.dart';
import 'package:dinde_market/provider/token_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dinde_market/models/district.dart';
import 'package:dinde_market/pages/navigation_page/cart_page/total_price_widget.dart';
import 'package:dinde_market/pages/navigation_page/profile_page/profile_widgets/edit_user_page.dart';
import 'package:dinde_market/pages/opening_pages/district_modal_widget.dart';
import 'package:dinde_market/provider/district_provider.dart';
import 'package:dinde_market/provider/user_provider.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:http/http.dart' as http;

class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  var selectedDistrict = "Выберите регион";
  var urlPrefix = "http://dindemarket.eu-north-1.elasticbeanstalk.com";

  final _formKey = GlobalKey<FormState>();

  var _firstNameController = TextEditingController();
  var _lastNameController = TextEditingController();
  var _phoneNumberController = TextEditingController();
  final _streetController = TextEditingController();
  final _unitController = TextEditingController();
  final _entranceController = TextEditingController();
  final _floorController = TextEditingController();
  final _customerCommentController = TextEditingController();

  String errorMessage = '';
  bool isValid = false;
  bool paymentSelected = false;
  @override
  void initState() {
    super.initState();

    // Initialize the late variable using ref in initState
    _firstNameController =
        TextEditingController(text: ref.read(userProvider).firstName);
    _lastNameController =
        TextEditingController(text: ref.read(userProvider).lastName);
    _phoneNumberController =
        TextEditingController(text: ref.read(userProvider).phoneNumber);
    selectedDistrict = ref.read(userProvider).region!.name;
  }

  void _validateForm() {
    setState(() {
      if (paymentSelected) {
        // If form is valid, do something
        isValid = true;
        errorMessage = '';
      } else {
        // If form is not valid, display an error message
        isValid = false;
        errorMessage = 'Выберите способ оплаты';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(244, 245, 249, 1),
        appBar: AppBar(
          title: const Text("Заказать"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(deliveryPriceProvider.notifier).state =
                  ref.read(userProvider).region?.priceDelivery ?? 0.0;
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final List<District> districtList =
                ref.read(districtProvider.notifier).state.toList();
            return Column(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 7),
                            color: Colors.white,
                            height: Utilities.setWidgetHeightByPercentage(
                                context, 30),
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
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  width: Utilities.setWidgetWidthByPercentage(
                                      context, 95),
                                  height: Utilities.setWidgetHeightByPercentage(
                                      context, 5.2),
                                  child: TextFormField(
                                    controller: _firstNameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Пожалуйста, введите имя'; // Validation message
                                      } else if (value.length < 2) {
                                        return 'Имя должно содержать не менее 2 символов';
                                      } else if (!RegExp(r'^[a-zA-Zа-яА-Я\s]+$')
                                          .hasMatch(value)) {
                                        return 'Имя должно содержать только буквы';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Имя",
                                      hintStyle: const TextStyle(
                                          color:
                                              Color.fromRGBO(135, 146, 155, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(185, 212, 191, 1),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(185, 212, 191, 1),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  width: Utilities.setWidgetWidthByPercentage(
                                      context, 95),
                                  height: Utilities.setWidgetHeightByPercentage(
                                      context, 5.2),
                                  child: TextFormField(
                                    controller: _lastNameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Пожалуйста, введите фамилию'; // Validation message
                                      } else if (value.length < 2) {
                                        return 'Фамилия должна содержать не менее 2 символов';
                                      } else if (!RegExp(r'^[a-zA-Zа-яА-Я\s]+$')
                                          .hasMatch(value)) {
                                        return 'Фамилия должна содержать только буквы';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Фамилия",
                                      hintStyle: const TextStyle(
                                          color:
                                              Color.fromRGBO(135, 146, 155, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(185, 212, 191, 1),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(185, 212, 191, 1),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  width: Utilities.setWidgetWidthByPercentage(
                                      context, 95),
                                  height: Utilities.setWidgetHeightByPercentage(
                                      context, 8),
                                  child: TextFormField(
                                    controller: _phoneNumberController,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(19),
                                      PhoneNumberInputFormatter(),
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Пожалуйста, введите номер телефона'; // Please enter a phone number
                                      } else if (!RegExp(
                                              r'^\+996 \(\d{3}\) \d{2} \d{2} \d{2}$')
                                          .hasMatch(value)) {
                                        return 'Формат номера телефона: +996 (XXX) XX XX XX'; // Phone number must follow the format +996 (XXX) XX XX XX
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "+996 (XXX) XX XX XX",
                                      hintStyle: const TextStyle(
                                          color:
                                              Color.fromRGBO(135, 146, 155, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(185, 212, 191, 1),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(185, 212, 191, 1),
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
                                context, 50),
                            child: Column(
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 10),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                            color: Color.fromRGBO(
                                                177, 207, 183, 1),
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
                                          ref
                                                  .read(deliveryPriceProvider
                                                      .notifier)
                                                  .state =
                                              districtList
                                                  .firstWhere((d) =>
                                                      d.name == newDistrict)
                                                  .priceDelivery;
                                        });
                                      }),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  width: Utilities.setWidgetWidthByPercentage(
                                      context, 95),
                                  height: Utilities.setWidgetHeightByPercentage(
                                      context, 5.2),
                                  child: TextFormField(
                                    controller: _streetController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Пожалуйста, введите название улицы';
                                      } else if (value.length < 3) {
                                        return 'Название улицы должно содержать не менее 3 символов';
                                      } else if (!RegExp(
                                              r'^[a-zA-Zа-яА-Я0-9\s]+$')
                                          .hasMatch(value)) {
                                        return 'Название улицы должно содержать только буквы, цифры';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Улица",
                                      hintStyle: const TextStyle(
                                          color:
                                              Color.fromRGBO(135, 146, 155, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(185, 212, 191, 1),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(185, 212, 191, 1),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        width: Utilities
                                            .setWidgetWidthByPercentage(
                                                context, 28),
                                        height: Utilities
                                            .setWidgetHeightByPercentage(
                                                context, 5.2),
                                        child: TextFormField(
                                          controller: _unitController,
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
                                        width: Utilities
                                            .setWidgetWidthByPercentage(
                                                context, 28),
                                        height: Utilities
                                            .setWidgetHeightByPercentage(
                                                context, 5.2),
                                        child: TextFormField(
                                          controller: _entranceController,
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
                                        width: Utilities
                                            .setWidgetWidthByPercentage(
                                                context, 28),
                                        height: Utilities
                                            .setWidgetHeightByPercentage(
                                                context, 5.2),
                                        child: TextFormField(
                                          controller: _floorController,
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
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  width: Utilities.setWidgetWidthByPercentage(
                                      context, 95),
                                  child: TextFormField(
                                    controller: _customerCommentController,
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
                                          color:
                                              Color.fromRGBO(135, 146, 155, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(185, 212, 191, 1),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(185, 212, 191, 1),
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
                                context, 20),
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
                                Column(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: !paymentSelected
                                                ? Border.all(
                                                    width: 1,
                                                    color: const Color.fromRGBO(
                                                        177, 207, 183, 1))
                                                : Border.all(
                                                    width: 2,
                                                    color: Colors.green)),
                                        width: Utilities
                                            .setWidgetWidthByPercentage(
                                                context, 95),
                                        height: Utilities
                                            .setWidgetHeightByPercentage(
                                                context, 8),
                                        child: TextButton(
                                          child: const Text(
                                            "Оплата \nонлайн",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (paymentSelected) {
                                                paymentSelected = false;
                                              } else {
                                                paymentSelected = true;
                                              }
                                            });
                                          },
                                        )),
                                    if (!isValid && errorMessage.isNotEmpty)
                                      Container(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          errorMessage,
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                      ),
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                    height: Utilities.setWidgetHeightByPercentage(context, 30),
                    child: TotalPriceWidget.totalPriceCalculation(
                        formKey: _formKey,
                        textButton: "Заказать",
                        validationform: _validateForm,
                        paymentSelected: paymentSelected,
                        rawOrder: Order(
                            phoneNumber: _phoneNumberController.text,
                            totalDiscount: 0.0,
                            id: 1,
                            deliveryPrice: 0.0,
                            orderStatus: {
                              OrderStatus.underReview: DateTime.now()
                            },
                            customerFirstName: _firstNameController.text,
                            customerLastName: _lastNameController.text,
                            customerAddress: CustomerAddress(
                                city: selectedDistrict,
                                street: _streetController.text,
                                unit: _unitController.text,
                                entrance: _entranceController.text,
                                floor: _floorController.text,
                                customerCommments:
                                    _customerCommentController.text),
                            orderedProducts: ref.read(cartListNotifierProvider),
                            totalOrderPrice: 0.0)))
              ],
            );
          },
        ));
  }
}
