import 'package:dinde_market/utility/utilities.dart';
import 'package:flutter/material.dart';

class DistrictModal {
  static districtModalWidget({required List<String> districtList, required BuildContext context}) {
    return showModalBottomSheet<String>(
      context: context,
      builder: (context){
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
          Container(
            height: Utilities.setWidgetHeightByPercentage(context, 57.5),
            decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)), color: Colors.white),
          ),
          Container(
            color: Colors.white,
            height: Utilities.setWidgetHeightByPercentage(context, 54.0),
            alignment: Alignment.center,
            child: ListView.separated(
              itemCount: districtList.length,
              separatorBuilder: (context, int) {
                return const SizedBox.shrink();
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    height: Utilities.setWidgetHeightByPercentage(context, 6.2),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey, width: 0.6))
                    ),
                    child: Row(children: [
                      Container(padding: const EdgeInsets.symmetric(horizontal: 10), child: const Icon(Icons.adjust),),
                      Text(districtList[index], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                    ],)
                  ),
                  onTap: () {
                    Navigator.of(context).pop(districtList[index]);
                  }
                );
              }
            ),
          )
        ],
        );
      }
    );
  }
  }
