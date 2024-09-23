import 'package:dinde_market/pages/navigation_bar_page.dart';
import 'package:dinde_market/pages/opening_pages/district_modal_widget.dart';
import 'package:dinde_market/provider/district_provider.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DistrictPage extends StatelessWidget {
  const DistrictPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 245, 249, 1),
      body: Column(
        children: [
          Expanded(
            flex: 220,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Image(image: const AssetImage('assets/green_logo.png'), width: Utilities.setWidgetWidthByPercentage(context, 19.6)),
            ),
          ),
          Expanded(
            flex: 113,
            child: Container(    
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(flex:33, child: Container()),
                  Expanded (
                    flex: 38,
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text("Выберите ваш регион", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Expanded(
                    flex: 42,
                    child: SizedBox(
                      width: Utilities.setWidgetWidthByPercentage(context, 91.5),
                      child: const DistrictDropDown(),
                    )
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 445,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: Utilities.setWidgetWidthByPercentage(context, 91.5),
                height: Utilities.setWidgetHeightByPercentage(context, 4.7),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NavigationBarPage()));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(98, 175, 28, 1),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)),),
                  ),
                  child: const Text("Далее", style: TextStyle(color: Colors.white),),
                )
              )
            )
          ),
          Expanded(
            flex: 34,
            child: Container(),
          )
        ],
      ),
    );
  }
}

class DistrictDropDown extends StatefulWidget {
  const DistrictDropDown({super.key});

  @override
  State<DistrictDropDown> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DistrictDropDown> {
  String dropdownValue = "";
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final List<String> districtList = ref.read(districtProvider.notifier).state.toList();
          dropdownValue = districtList.first;
        return SizedBox.expand(
          child: TextButton(
            style: TextButton.styleFrom(
              side: const BorderSide(color: Color.fromRGBO(177, 207, 183, 1), width: 1.0),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)),),
            ),
              child: Text(dropdownValue, textAlign: TextAlign.center,),
            onPressed: () async {
              final selectedDistrict = await DistrictModal.districtModalWidget(context: context, districtList: districtList);
              setState(() {
                dropdownValue = selectedDistrict;
              });
            } 
          ),
    );
      },
    );
  }
}