import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dinde_market/provider/buttom_nav_bar_provider.dart';
import 'package:dinde_market/utility/utilities.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  RangeValues values = const RangeValues(10, 30000);
  RangeLabels labels = const RangeLabels('10', '30000');
  RangeValues rangeSliderValues = const RangeValues(10, 30000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(244, 245, 249, 1),
      body: Column(
        children: [
          Container(
            height: Utilities.setWidgetHeightByPercentage(context, 6),
          ),
          Expanded(
            flex: 42,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal:
                        Utilities.setWidgetWidthByPercentage(context, 2)),
                child: Consumer(
                  builder: (context, ref, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            ref
                                .read(bottomNavBarVisibilityProvider.notifier)
                                .state = true;
                            Navigator.of(context).pop(null);
                          },
                          child: const Icon(Icons.close),
                        ),
                        const Text('Фильтры'),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              values = const RangeValues(10, 30000);
                              rangeSliderValues = const RangeValues(10, 30000);
                            });
                          },
                          child: const Text('Очистить'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 68,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal:
                      Utilities.setWidgetWidthByPercentage(context, 4.3)),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width:
                            Utilities.setWidgetWidthByPercentage(context, 40),
                        alignment: Alignment.bottomLeft,
                        child: const Text(
                          "от",
                          style: TextStyle(
                              color: Color.fromRGBO(138, 138, 142, 1),
                              fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        width:
                            Utilities.setWidgetWidthByPercentage(context, 40),
                        height:
                            Utilities.setWidgetHeightByPercentage(context, 5),
                        child: TextField(
                          controller: TextEditingController(
                              text: values.start.round().toString()),
                          onSubmitted: (value) {
                            setState(() {
                              double newStartValue = double.parse(value);
                              values = RangeValues(newStartValue, values.end);
                            });
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(177, 175, 175, 1),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(98, 175, 28, 1),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text("-"),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width:
                            Utilities.setWidgetWidthByPercentage(context, 40),
                        child: const Text(
                          "до",
                          style: TextStyle(
                              color: Color.fromRGBO(138, 138, 142, 1),
                              fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        width:
                            Utilities.setWidgetWidthByPercentage(context, 40),
                        height:
                            Utilities.setWidgetHeightByPercentage(context, 5),
                        child: TextField(
                          controller: TextEditingController(
                              text: values.end.round().toString()),
                          onSubmitted: (value) {
                            setState(() {
                              double newEndValue = double.parse(value);
                              values = RangeValues(values.start, newEndValue);
                            });
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(177, 175, 175, 1),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(98, 175, 28, 1),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 46,
            child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal:
                        Utilities.setWidgetWidthByPercentage(context, 4.3)),
                alignment: Alignment.bottomCenter,
                child: SliderTheme(
                  data: const SliderThemeData(
                      showValueIndicator: ShowValueIndicator.never,
                      trackHeight: 1,
                      rangeThumbShape:
                          RoundRangeSliderThumbShape(enabledThumbRadius: 5)),
                  child: RangeSlider(
                    values: rangeSliderValues,
                    min: 10,
                    max: 30000,
                    divisions: 29990,
                    labels: labels,
                    activeColor: const Color.fromRGBO(98, 175, 28, 1),
                    onChanged: (newValue) {
                      setState(() {
                        rangeSliderValues = newValue;
                        values = rangeSliderValues;
                      });
                    },
                  ),
                )),
          ),
          Expanded(
            flex: 560,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal:
                        Utilities.setWidgetWidthByPercentage(context, 4.3),
                    vertical: 10),
                width: Utilities.setWidgetWidthByPercentage(context, 95),
                height: Utilities.setWidgetHeightByPercentage(context, 5.2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromRGBO(98, 175, 28, 1),
                ),
                alignment: Alignment.bottomCenter,
                child: Consumer(
                  builder: (context, ref, child) {
                    return TextButton(
                      onPressed: () {
                        ref
                            .read(bottomNavBarVisibilityProvider.notifier)
                            .state = true;
                        Navigator.of(context).pop(values);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "Показать товары",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
