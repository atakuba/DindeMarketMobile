import 'dart:convert';

import 'package:dinde_market/config/database_configuration.dart';
import 'package:dinde_market/main.dart';
import 'package:dinde_market/models/district.dart';
import 'package:dinde_market/models/user.dart';
import 'package:dinde_market/pages/opening_pages/district_modal_widget.dart';
import 'package:dinde_market/provider/district_provider.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class DistrictPage extends ConsumerStatefulWidget {
  const DistrictPage({super.key});

  @override
  _DistrictPageState createState() => _DistrictPageState();
}

class _DistrictPageState extends ConsumerState<DistrictPage> {
  String selectedDistrict = "";
  var urlPrefix = "http://dindemarket.eu-north-1.elasticbeanstalk.com";
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  List<District> districtList = [];

  @override
  void initState() {
    super.initState();
    fetchRegions();
  }

  Future<void> fetchRegions() async {
    final response = await http.get(Uri.parse('$urlPrefix/api/regions'));
    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the JSON.
      var decodeFormat = utf8.decode(response.bodyBytes);
      var data = json.decode(decodeFormat);
      if (data is List) {
        districtList = data.map((json) => District.fromJson(json)).toList();

        // addDistrictsToDb(districtList);
        selectedDistrict = districtList.first.name;
        ref.read(districtProvider.notifier).state = districtList;
        setState(() {});
      } else {
        print('Error: Decoded data is not a list');
      }
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }

  void addUserToDb(User user) async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    await dbHelper.insertUser(user.toMap());
  }

  void addDistrictsToDb(List<District> districts) async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    await dbHelper.insertAllDistrict(districts);
  }

  Future<void> postRegionsID(String region) async {
    int regionId = ref
        .read(districtProvider.notifier)
        .state
        .firstWhere((d) => d.name == region)
        .id;
    final url = Uri.parse("$urlPrefix/api/clients");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"regionId": regionId});
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        var decodeFormat = utf8.decode(response.bodyBytes);
        final data = jsonDecode(decodeFormat);
        secureStorage.write(key: "auth_token", value: data['token']);
        User user = User(
            id: data['id'],
            firstName: data['firstName'],
            lastName: data['lastName'],
            phoneNumber: data['phoneNumber'] ?? "+996 (000) 00 00 00",
            address: data['address'] ?? "Не указано",
            district: region,
            username: data['username']);
        addUserToDb(user);
      } else {
        print('Failed to post data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

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
              child: Image(
                image: const AssetImage('assets/green_logo.png'),
                width: Utilities.setWidgetWidthByPercentage(context, 19.6),
              ),
            ),
          ),
          Expanded(
            flex: 113,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Выберите Регион",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  width: Utilities.setWidgetWidthByPercentage(context, 90),
                  child: TextButton(
                      style: TextButton.styleFrom(
                        side: const BorderSide(
                            color: Color.fromRGBO(177, 207, 183, 1),
                            width: 1.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      child: Text(
                        selectedDistrict,
                        textAlign: TextAlign.center,
                        style: const TextStyle(),
                      ),
                      onPressed: () async {
                        final newDistrict =
                            await DistrictModal.districtModalWidget(
                                context: context, districtList: districtList);
                        setState(() {
                          selectedDistrict = newDistrict;
                        });
                      }),
                ),
              ],
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
                  onPressed: () async {
                    if (selectedDistrict.isNotEmpty) {
                      addDistrictsToDb(ref.read(districtProvider));
                      await postRegionsID(selectedDistrict);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MyApp()));
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(98, 175, 28, 1),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  child: const Text(
                    "Далее",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          const Expanded(flex: 34, child: SizedBox())
        ],
      ),
    );
  }
}
