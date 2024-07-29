import 'package:dinde_market/utility/utilities.dart';
import 'package:flutter/material.dart';

class CustomizedSearchBar extends StatelessWidget {
  final BuildContext context;

  const CustomizedSearchBar({Key? key, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: Utilities.setWidgetWidthByPercentage(context, 91.5),
        height: Utilities.setWidgetHeightByPercentage(context, 8.6),
        alignment: Alignment.center,
        child: SizedBox(
          height: Utilities.setWidgetHeightByPercentage(context, 4.9),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              filled: true,
              hintStyle: const TextStyle(color: Color.fromRGBO(135, 146, 155, 1)),
              fillColor: const Color.fromRGBO(230, 234, 237, 1),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color.fromRGBO(230, 234, 237, 1), width: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color.fromRGBO(230, 234, 237, 1), width: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Искать товары',
              prefixIcon: const Icon(Icons.search, color: Color.fromRGBO(35, 170, 73, 1)),
            ),
          ),
        ),
      ),
    );
  }
}
