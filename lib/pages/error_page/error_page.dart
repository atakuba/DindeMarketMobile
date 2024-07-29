import 'package:dinde_market/utility/utilities.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 392,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image(image: const AssetImage('assets/error_pic.png'), width: Utilities.setWidgetWidthByPercentage(context, 73.6),),
            ),
          ),
          const Expanded(
            flex: 54,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text("Упс! Что то пошло не так"),
            ),
          ),
          Expanded(
            flex: 50,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Utilities.setWidgetWidthByPercentage(context, 9.9)),
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: Text("Пожалуйста проверьте ваше интернет соединение, затем обновите страницу", textAlign: TextAlign.center,),
              ),
            ),
          ),
          Expanded(
            flex: 67,
            child: SizedBox(
              width: Utilities.setWidgetWidthByPercentage(context, 63.5),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: Utilities.setWidgetHeightByPercentage(context, 4.3),
                  width: double.infinity,
                  child: TextButton(onPressed: () {Navigator.of(context).pop();}, 
                    style: TextButton.styleFrom(
                      side: const BorderSide(color: Color.fromRGBO(98, 175, 28, 1), width: 1.0),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)),),
                    ),
                    child: const Text("Обновить", textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(98, 175, 28, 1)),),
                  )
                ),
              ),
            ),
          ),
          Expanded(
            flex: 249,
            child: Container(),
          )
        ],  
      ),
    );
  }
}