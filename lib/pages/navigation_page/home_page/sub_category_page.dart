import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dinde_market/models/sub_category.dart';
import 'package:dinde_market/pages/navigation_page/home_page/product_list_page.dart';
import 'package:dinde_market/provider/products_provider.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:dinde_market/widgets/serach_bar.dart';

class SubCategoryPage extends StatelessWidget {
  final String categoryName;
  final List<SubCategory> subcategoryList;

  const SubCategoryPage(
      {super.key, required this.categoryName, required this.subcategoryList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: Utilities.setWidgetHeightByPercentage(context, 6),
          ),
          Row(
            children: [
              SizedBox(
                width: Utilities.setWidgetWidthByPercentage(context, 12),
                child: InkWell(
                  child: const Icon(Icons.arrow_back),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                width: Utilities.setWidgetWidthByPercentage(context, 88),
                height: Utilities.setWidgetHeightByPercentage(context, 5.2),
                alignment: Alignment.center,
                child: Text(
                  categoryName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Container(
              alignment: Alignment.center,
              child: CustomizedSearchBar(context: context)),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.zero,
                      height:
                          Utilities.setWidgetHeightByPercentage(context, 61),
                      width: Utilities.setWidgetWidthByPercentage(context, 95),
                      child: Consumer(
                        builder: (context, ref, child) {
                          ref.watch(productListProvider);
                          return ListView.separated(
                            itemCount: subcategoryList.length,
                            padding: EdgeInsets.zero,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                              height: 0.01,
                              color: Color.fromRGBO(230, 234, 251, 1),
                            ),
                            itemBuilder: (context, index) {
                              final subCategory = subcategoryList[index];
                              // final productList = ref.watch(productListProvider.notifier).state.where((p) => p.subCategoryId == subCategory.id).toList();
                              if (subcategoryList.isNotEmpty) {
                                return InkWell(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height:
                                        Utilities.setWidgetHeightByPercentage(
                                            context, 5.5),
                                    child: Text(
                                      subCategory.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductListPage(
                                                    productListDisplay:
                                                        subCategory.productList,
                                                    pageTitle:
                                                        subCategory.name)));
                                  },
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
