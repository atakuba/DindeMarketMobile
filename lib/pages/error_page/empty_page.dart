import 'package:dinde_market/pages/navigation_bar_page.dart';
import 'package:dinde_market/provider/buttom_nav_bar_provider.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';

class EmptyPage {
  static Widget emptyPage({
    required BuildContext context,
    required String firstText,
    required String secondText,
    required String thirdText,
    required WidgetRef ref,
  }) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.center,
            child: Text(
              firstText,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: Utilities.setWidgetWidthByPercentage(context, 62),
            alignment: Alignment.center,
            child: Text(
              secondText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Container(
            width: Utilities.setWidgetWidthByPercentage(context, 62),
            height: 40,
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(98, 175, 28, 1),
                borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: InkWell(
              child: Text(
                thirdText,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                ref.read(selectedIndexProvider.notifier).state = 0;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NavigationBarPage()));
              },
            ),
          )
        ],
      ),
    );
  }
}
