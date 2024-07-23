import 'package:flutter/material.dart';

class DistrictPage extends StatelessWidget {
  const DistrictPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 226, 226),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Image(image: AssetImage('assets/green_logo.png'), width: 200)],
              )            
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(              
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded (
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                      child: const Text("Choose your district", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const Expanded(
                    flex: 9,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: DropdownMenuExample(),
                    )
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              // height: 500,
              child: NextButton(),
            )
          ),
        ],
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
    static const List<String> _districts = ['Bishkek city', 'Osh city', 'Batken district', 'Osh district', 'Talas district', 'Zhalal-Abad district', 'Naryn district', 'Chui district', 'Yssyk-Kul district'];
  String dropdownValue = _districts.first;
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 143, 161, 145), width: 2),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text(dropdownValue, textAlign: TextAlign.center,),
              ),
            onPressed: () => showModal(context),
          ),
        ],
      ),
    );
  }
void showModal(context){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          padding: EdgeInsets.all(30),
          height: 500,
          alignment: Alignment.center,
          child: ListView.separated(
            itemCount: _districts.length,
            separatorBuilder: (context, int) {
              return Divider();
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Text(_districts[index]),
                onTap: () {
                  setState(() {
                    dropdownValue = _districts[index];
                  });
                  Navigator.of(context).pop();
                }
              );
            }
          ),
        );
      }
    );
  }
}
class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 96, 176, 4),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Change border radius here
        ),
      ),
      child: const Text('Next'),
    );
  }
}