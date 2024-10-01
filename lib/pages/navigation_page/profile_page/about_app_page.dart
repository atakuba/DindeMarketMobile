import 'package:flutter/material.dart';

import 'package:dinde_market/models/mock_data/mock_data.dart';

class AboutAppPage extends StatefulWidget {
  const AboutAppPage({super.key});

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  @override
  Widget build(BuildContext context) {
    final aboutApp = MyAboutApp.aboutApp;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("О приложении"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 35),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                aboutApp.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              // Wrap ListView.builder with Expanded
              child: ListView.builder(
                itemCount: aboutApp.titleAndContext.length,
                itemBuilder: (context, index) {
                  final titleAndContext = aboutApp.titleAndContext[index];
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Text("${titleAndContext['key']}",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text("${titleAndContext['value']}",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w300)),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
