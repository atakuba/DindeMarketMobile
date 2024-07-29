import 'package:dinde_market/models/mock_data/mock_data.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:dinde_market/widgets/serach_bar.dart';
import 'package:flutter/material.dart';

class SubCategoryPage extends StatelessWidget {
  final int categoryID;
  final String categoryName;

  const SubCategoryPage(
      {super.key, required this.categoryID, required this.categoryName});

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
                      child: ListView.separated(
                        itemCount: MySubCategories.subCategoryList.length,
                        padding: EdgeInsets.zero,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          height: 0.01,
                          color: Color.fromRGBO(230, 234, 251, 1),
                        ),
                        itemBuilder: (context, index) {
                          final allSubCategories =
                              MySubCategories.subCategoryList[index];
                          if (categoryID == allSubCategories.category.id) {
                            return InkWell(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 5.5),
                                child: Text(
                                  allSubCategories.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              ),
                              onTap: () {},
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
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
