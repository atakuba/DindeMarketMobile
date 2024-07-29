import 'package:dinde_market/utility/utilities.dart';
import 'package:flutter/material.dart';

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
                  onPressed: () {},
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
    static const List<String> _districts = ['г. Бишкек', 'г. Ош', 'Баткенская область', 'Джалал-Абадская область', 'Иссык-Кульская область', 'Нарынская область', 'Ошская область', 'Таласская область', 'Чуйская область'];
  String dropdownValue = _districts.first;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
          child: TextButton(
            style: TextButton.styleFrom(
              side: const BorderSide(color: Color.fromRGBO(177, 207, 183, 1), width: 1.0),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)),),
            ),
              child: Text(dropdownValue, textAlign: TextAlign.center,),
            onPressed: () => showModal(context),
          ),
    );
  }
void showModal(context){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          child: Stack(
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
                itemCount: _districts.length,
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
                        Text(_districts[index], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                      ],)
                    ),
                    onTap: () {
                      setState(() {
                        dropdownValue = _districts[index];
                      });
                      Navigator.of(context).pop();
                    }
                  );
                }
              ),
            )
          ],
          )
        );
      }
    );
  }
}