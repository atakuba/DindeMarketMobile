import 'package:dinde_market/pages/navigation_page/profile_page/about_app_page.dart';
import 'package:dinde_market/pages/navigation_page/profile_page/contact_us_modal.dart';
import 'package:dinde_market/pages/navigation_page/profile_page/order_history_page.dart';
import 'package:dinde_market/pages/navigation_page/profile_page/user_info_page.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(244, 245, 249, 1),
      child: Column(
      children: [
        Container(
              color: const Color.fromRGBO(255, 255, 255, 1),
              height: Utilities.setWidgetHeightByPercentage(context, 6),
            ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: const Text("Профиль", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
          ),),
        Expanded(
          flex: 15,
          child: SizedBox(
                  width: Utilities.setWidgetWidthByPercentage(context, 88.3),
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              children: [
                InkWell(
                  child: Container(
                  alignment: Alignment.center,
                  height: Utilities.setWidgetHeightByPercentage(context, 8),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(15),
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle
                            ),
                            child: const Icon(Icons.person_outline_rounded, color: Colors.white,),
                          ),
                      const Text("Мои данные", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                        ],
                      ),
                      Container(
                            margin: const EdgeInsets.all(15),
                        child: const Icon(Icons.arrow_forward_ios, color: Color.fromRGBO(138, 138, 142, 1),)
                      )
                    ],
                  ),
                ),
                //push new page
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserInfoPage()));
                },
                ),
                const Divider(color: Color.fromRGBO(244, 245, 249, 1), height: 0,),
                InkWell(
                  child: Container(
                  alignment: Alignment.center,
                  height: Utilities.setWidgetHeightByPercentage(context, 8),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(15),
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle
                            ),
                            child: const Icon(Icons.history_edu_outlined, color: Colors.white,),
                          ),
                      const Text("История заказов", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                        ],
                      ),
                      Container(
                            margin: const EdgeInsets.all(15),
                        child: const Icon(Icons.arrow_forward_ios, color: Color.fromRGBO(138, 138, 142, 1),)
                      )
                    ],
                  ),
                ),
                //push new page
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OrderHistoryPage()));
                },
                ),
                const Divider(color: Color.fromRGBO(244, 245, 249, 1), height: 0,),
                InkWell(
                  child: Container(
                  alignment: Alignment.center,
                  height: Utilities.setWidgetHeightByPercentage(context, 8),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(15),
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle
                            ),
                            child: const Icon(Icons.phone_iphone_outlined, color: Colors.white,),
                          ),
                      const Text("О приложении", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                        ],
                      ),
                      Container(
                            margin: const EdgeInsets.all(15),
                        child: const Icon(Icons.arrow_forward_ios, color: Color.fromRGBO(138, 138, 142, 1),)
                      )
                    ],
                  ),
                ),
                //push new page
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AboutAppPage()));
                },
                ),
                const Divider(color: Color.fromRGBO(244, 245, 249, 1), height: 0,),
                InkWell(
                  child: Container(
                  alignment: Alignment.center,
                  height: Utilities.setWidgetHeightByPercentage(context, 8),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(15),
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle
                            ),
                            child: const Icon(Icons.phone_outlined, color: Colors.white,),
                          ),
                      const Text("Связаться с нами", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                        ],
                      ),
                      Container(
                            margin: const EdgeInsets.all(15),
                        child: const Icon(Icons.arrow_forward_ios, color: Color.fromRGBO(138, 138, 142, 1),)
                      )
                    ],
                  ),
                ),
                //push new page
                onTap: () {
                  ContactUsModal.showImageModal(context: context);
                },
                )
              ],
            ),
            ))
      ],
    )
    );
  }
}