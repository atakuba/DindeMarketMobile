import 'package:dinde_market/pages/navigation_page/profile_page/profile_widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> with SingleTickerProviderStateMixin {

  late TabController controller;
  
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
        title: Text("История заказов"),
        centerTitle: true,
        bottom: TabBar(
          labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.green,
          labelColor: Colors.black,
          unselectedLabelColor: Color.fromRGBO(166, 166, 166, 1),
          controller: controller,
          tabs: const [
            Tab(text: "Текущие",),
            Tab(text: "История",)
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          Container(
            color: Colors.lightBlueAccent,
            child: Consumer(
              builder: (context, ref, child) {
                return ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                
              },
            );
              },
            ),
          ),
          Container(
            color: Colors.lightGreenAccent,
          )
        ],
      ),
    );
  }
}