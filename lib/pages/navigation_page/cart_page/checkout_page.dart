import 'package:dinde_market/models/order.dart';
import 'package:dinde_market/provider/cart_list_provider.dart';
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

class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  var selectedDistrict = "Выберите регион";

  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

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
  bool isOnlinePaymentSelected = false;
  bool isCashPaymentSelected = false;

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
      if (isOnlinePaymentSelected || isCashPaymentSelected) {
        // If at least one payment method is selected, the form is valid
        isValid = true;
        errorMessage = '';
      } else {
        // If no payment method is selected, display an error message
        isValid = false;
        errorMessage = 'Выберите способ оплаты';
        _scrollToPosition('bottom');
      }
    });
  }
  

  void _scrollToPosition(String position) {
  double targetScrollPosition;

  switch (position.toLowerCase()) {
    case 'top':
      targetScrollPosition = _scrollController.position.minScrollExtent; // Scroll to the top
      break;
    case 'middle':
      targetScrollPosition = _scrollController.position.maxScrollExtent / 2; // Scroll to the middle
      break;
    case 'bottom':
      targetScrollPosition = _scrollController.position.maxScrollExtent; // Scroll to the bottom
      break;
    default:
      targetScrollPosition = _scrollController.position.minScrollExtent; // Invalid argument, do nothing or handle as needed
  }

  _scrollController.animateTo(
    targetScrollPosition,
    duration: const Duration(seconds: 1),
    curve: Curves.easeInOut,
  );


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
                      controller: _scrollController,
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 7),
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
                                      context, 8),
                                  child: TextFormField(
                                    controller: _firstNameController,
                                    validator: (value) {
                                      // _scrollToPosition('top');
                                      // _scrollController.jumpTo(_scrollController.position.minScrollExtent);
                                      if (value == null || value.isEmpty) {
                                      _scrollToPosition('top');
                                        return 'Пожалуйста, введите имя'; // Validation message
                                      } else if (value.length < 2) {
                                      _scrollToPosition('top');
                                        return 'Имя должно содержать не менее 2 символов';
                                      } else if (!RegExp(r'^[a-zA-Zа-яА-Я\s]+$')
                                          .hasMatch(value)) {
                                      _scrollToPosition('top');
                                        return 'Имя должно содержать только буквы';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 10),
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
                                      errorBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(214, 18, 18, 1),
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
                                      context, 8),
                                  child: TextFormField(
                                    controller: _lastNameController,
                                    validator: (value) {
                                      // _scrollToPosition('top');
                                      // _scrollController.jumpTo(_scrollController.position.minScrollExtent);
                                      if (value == null || value.isEmpty) {
                                      _scrollToPosition('top');
                                        return 'Пожалуйста, введите фамилию'; // Validation message
                                      } else if (value.length < 2) {
                                      _scrollToPosition('top');
                                        return 'Фамилия должна содержать не менее 2 символов';
                                      } else if (!RegExp(r'^[a-zA-Zа-яА-Я\s]+$')
                                          .hasMatch(value)) {
                                      _scrollToPosition('top');
                                        return 'Фамилия должна содержать только буквы';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 10),
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
                                      errorBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(214, 18, 18, 1),
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
                                      context, 12),
                                  child: TextFormField(
                                    controller: _phoneNumberController,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(19),
                                      PhoneNumberInputFormatter(),
                                    ],
                                    validator: (value) {
                                      // _scrollToPosition('top');
                                      // _scrollController.jumpTo(_scrollController.position.minScrollExtent);
                                      if (value == null || value.isEmpty) {
                                      _scrollToPosition('top');
                                        return 'Пожалуйста, введите номер телефона'; // Please enter a phone number
                                      } else if (!RegExp(
                                              r'^\+996 \(\d{3}\) \d{2} \d{2} \d{2}$')
                                          .hasMatch(value)) {
                                      _scrollToPosition('top');
                                        return 'Формат номера телефона: +996 (XXX) XX XX XX'; // Phone number must follow the format +996 (XXX) XX XX XX
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 10),
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
                                      errorBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(214, 18, 18, 1),
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
                                      context, 8),
                                  child: TextFormField(
                                    controller: _streetController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                      _scrollToPosition('middle');
                                        return 'Пожалуйста, введите название улицы';
                                      } else if (value.length < 3) {
                                      _scrollToPosition('middle');
                                        return 'Название улицы должно содержать не менее 3 символов';
                                      } else if (!RegExp(
                                              r'^[a-zA-Zа-яА-Я0-9\s]+$')
                                          .hasMatch(value)) {
                                      _scrollToPosition('middle');
                                        return 'Название улицы должно содержать только буквы, цифры';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 10),
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
                                      errorBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(214, 18, 18, 1),
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
                                                context, 8),
                                        child: TextFormField(
                                          controller: _unitController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
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
                                                context, 8),
                                        child: TextFormField(
                                          controller: _entranceController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
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
                                                context, 8),
                                        child: TextFormField(
                                          controller: _floorController,
                                          textAlign: TextAlign.left,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
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
                                  height: Utilities.setWidgetHeightByPercentage(
                                      context, 11),
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
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20,
                                            top: 5,
                                            bottom: 5,
                                            right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: isOnlinePaymentSelected
                                              ? Border.all(
                                                  width: 2, color: Colors.green)
                                              : Border.all(
                                                  width: 1,
                                                  color: const Color.fromRGBO(
                                                      177, 207, 183, 1)),
                                        ),
                                        width: Utilities
                                            .setWidgetWidthByPercentage(
                                                context, 41),
                                        height: Utilities
                                            .setWidgetHeightByPercentage(
                                                context, 8),
                                        child: TextButton(
                                          child: const Text(
                                            textAlign: TextAlign.center,
                                            "Оплата \nонлайн",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              // Deselect cash payment if online is selected
                                              isOnlinePaymentSelected = true;
                                              isCashPaymentSelected =
                                                  false; // Deselect the cash payment option
        errorMessage = '';
        isValid = true;
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 10,
                                            top: 5,
                                            bottom: 5,
                                            right: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: isCashPaymentSelected
                                              ? Border.all(
                                                  width: 2, color: Colors.green)
                                              : Border.all(
                                                  width: 1,
                                                  color: const Color.fromRGBO(
                                                      177, 207, 183, 1)),
                                        ),
                                        width: Utilities
                                            .setWidgetWidthByPercentage(
                                                context, 41),
                                        height: Utilities
                                            .setWidgetHeightByPercentage(
                                                context, 8),
                                        child: TextButton(
                                          child: const Text(
                                            textAlign: TextAlign.center,
                                            "Оплата \nналичными",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              // Deselect online payment if cash is selected
                                              isCashPaymentSelected = true;
                                              isOnlinePaymentSelected =
                                                  false; // Deselect the online payment option
        errorMessage = '';
        isValid = true;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (!isValid && errorMessage.isNotEmpty)
                                    Container(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        errorMessage,
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                    ),
                                ],
                              )
                            ],
                          ),
                        ),
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
                        isCashPaymentSelected: isCashPaymentSelected,
                        isOnlinePaymentSelected: isOnlinePaymentSelected,
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
