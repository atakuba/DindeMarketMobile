import 'package:dinde_market/config/database_configuration.dart';
import 'package:dinde_market/models/district.dart';
import 'package:dinde_market/models/user.dart';
import 'package:dinde_market/pages/navigation_page/profile_page/profile_widgets/edit_user_page.dart';
import 'package:dinde_market/provider/cart_list_provider.dart';
import 'package:dinde_market/provider/district_provider.dart';
import 'package:dinde_market/provider/user_provider.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  void updateUserById(User user) async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    await dbHelper.updateUser(user.id, user.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var user = ref.watch(userProvider.notifier).state;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Мои данные"),
            centerTitle: true,
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height:
                            Utilities.setWidgetHeightByPercentage(context, 19),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.person_outline,
                            size: 80,
                          ),
                        )),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 3.2),
                                child: const Text("Имя:",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromRGBO(138, 138, 142, 1))),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 4.2),
                                child: Text(
                                  user.firstName,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromRGBO(138, 138, 142, 1),
                          )
                        ],
                      ),
                      onTap: () async {
                        final newFirstName =
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditUserPage(
                                      isTextField: true,
                                      title: "Имя",
                                      textFieldLabel: "Ваше имя",
                                      textFieldValue: user.firstName,
                                      textFieldHint: "Введите Ваше имя",
                                    )));
                        ref
                            .read(userProvider.notifier)
                            .updateFirstName(newFirstName);
                        user = user.copyWith(firstName: newFirstName);
                        updateUserById(user);
                        setState(() {});
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: const Divider(
                        color: Color.fromRGBO(244, 245, 249, 1),
                        height: 0,
                      ),
                    ),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 3.2),
                                child: const Text("Фамилия:",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromRGBO(138, 138, 142, 1))),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 4.2),
                                child: Text(
                                  user.lastName,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromRGBO(138, 138, 142, 1),
                          )
                        ],
                      ),
                      onTap: () async {
                        final newLastName = await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => EditUserPage(
                                    isTextField: true,
                                    title: "Фамилия",
                                    textFieldLabel: "Вашa Фамилия",
                                    textFieldValue: user.lastName,
                                    textFieldHint: "Введите Вашу Фамилию")));
                        ref
                            .read(userProvider.notifier)
                            .updateLastName(newLastName);
                        user = user.copyWith(lastName: newLastName);
                        updateUserById(user);
                        setState(() {});
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: const Divider(
                        color: Color.fromRGBO(244, 245, 249, 1),
                        height: 0,
                      ),
                    ),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 3.2),
                                child: const Text("Номер телефона:",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromRGBO(138, 138, 142, 1))),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 4.2),
                                child: Text(
                                  user.phoneNumber ?? "",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromRGBO(138, 138, 142, 1),
                          )
                        ],
                      ),
                      onTap: () async {
                        final newPhoneNumber =
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditUserPage(
                                      isTextField: true,
                                      title: "Номер телефона",
                                      textFieldLabel: "Номер телефона",
                                      textFieldValue: user.phoneNumber ?? "",
                                      textFieldHint: "+996 ( ___ ) __ __ __",
                                    )));
                        ref
                            .read(userProvider.notifier)
                            .updatePhoneNumber(newPhoneNumber);
                        user = user.copyWith(phoneNumber: newPhoneNumber);
                        updateUserById(user);
                        setState(() {});
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: const Divider(
                        color: Color.fromRGBO(244, 245, 249, 1),
                        height: 0,
                      ),
                    ),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 3.2),
                                child: const Text("Регион:",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromRGBO(138, 138, 142, 1))),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 4.2),
                                child: Text(
                                  user.region?.name ?? "",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromRGBO(138, 138, 142, 1),
                          )
                        ],
                      ),
                      onTap: () async {
                        String newRegion =
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditUserPage(
                                      isTextField: false,
                                      title: "Регион",
                                      textFieldLabel: "Ваш Регион",
                                      textFieldValue: user.region?.name ?? "",
                                      textFieldHint: "Введите Ваш Регион",
                                    )));
                        District district = ref
                            .read(districtProvider.notifier)
                            .state
                            .firstWhere((d) => d.name == newRegion);
                        ref
                            .read(userProvider.notifier)
                            .updateDistrict(newRegion);
                        ref.read(userProvider.notifier).updateRegion(district);
                        ref.read(deliveryPriceProvider.notifier).state =
                            district.priceDelivery;
                        user = user.copyWith(district: newRegion);
                        updateUserById(user);
                        setState(() {});
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
