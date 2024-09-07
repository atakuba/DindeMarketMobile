import 'package:dinde_market/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderCard extends ConsumerStatefulWidget {
  final Order order;
  const OrderCard(this.order, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderCardState();
}

class _OrderCardState extends ConsumerState<OrderCard> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}