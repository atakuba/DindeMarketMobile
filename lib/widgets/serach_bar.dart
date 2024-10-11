import 'dart:convert';

import 'package:dinde_market/models/sub_category.dart';
import 'package:dinde_market/pages/navigation_page/home_page/sub_category_page.dart';
import 'package:dinde_market/provider/token_provider.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class CustomizedSearchBar extends ConsumerStatefulWidget {
  final BuildContext parentContext;

  const CustomizedSearchBar({Key? key, required this.parentContext})
      : super(key: key);

  @override
  ConsumerState<CustomizedSearchBar> createState() =>
      _CustomizedSearchBarState();
}

class _CustomizedSearchBarState extends ConsumerState<CustomizedSearchBar> {
  // Add any internal state variables here if needed (e.g., for managing text input)
  late TextEditingController _searchController;
  List<SubCategory> searchSubcategoryList = [];
  var urlPrefix = "http://dindemarket.eu-north-1.elasticbeanstalk.com";

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(); // Initialize controller
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose controller when no longer needed
    super.dispose();
  }

  Future<void> fetchSearchSubcategories(String productName) async {
    final response = await http.get(
      Uri.parse(
        '$urlPrefix/subcategories/search?name=$productName',
      ),
      headers: {
        'Authorization': 'Bearer ${ref.read(tokenProvider)}',
        'Content-Type': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the JSON.
      var decodeFormat = utf8.decode(response.bodyBytes);
      var data = json.decode(decodeFormat);
      if (data is List) {
        List<SubCategory> fetchSearchSubcategories = data
            .map((json) => SubCategory.fromJson(json))
            .cast<SubCategory>()
            .toList();
        setState(() {
          searchSubcategoryList = fetchSearchSubcategories;
        });
      } else {}
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: Utilities.setWidgetWidthByPercentage(widget.parentContext, 91.5),
        height:
            Utilities.setWidgetHeightByPercentage(widget.parentContext, 8.6),
        alignment: Alignment.center,
        child: SizedBox(
          height:
              Utilities.setWidgetHeightByPercentage(widget.parentContext, 4.9),
          child: TextFormField(
            controller: _searchController,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              filled: true,
              hintStyle:
                  const TextStyle(color: Color.fromRGBO(135, 146, 155, 1)),
              fillColor: const Color.fromRGBO(230, 234, 237, 1),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromRGBO(230, 234, 237, 1), width: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromRGBO(230, 234, 237, 1), width: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Искать товары',
              prefixIcon: const Icon(Icons.search,
                  color: Color.fromRGBO(35, 170, 73, 1)),
            ),
            onFieldSubmitted: (value) async {
              if (value.isNotEmpty) {
                await fetchSearchSubcategories(value);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SubCategoryPage(
                        categoryName: 'Результаты: $value',
                        subcategoryList: searchSubcategoryList)));
              }
            },
          ),
        ),
      ),
    );
  }
}
