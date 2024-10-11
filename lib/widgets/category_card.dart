import 'package:flutter/material.dart';

import 'package:dinde_market/models/category.dart';
import 'package:dinde_market/pages/navigation_page/home_page/sub_category_page.dart';
import 'package:dinde_market/utility/utilities.dart';

class CategoryCard extends StatefulWidget {
  final Category category;
  // final bool topTitle;

  const CategoryCard({
    super.key,
    required this.category,
  });

  @override
  State<CategoryCard> createState() => CategoryCardState();
}

class CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: Utilities.setWidgetWidthByPercentage(context, 28.8),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Text(
                  widget.category.name,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                  width: Utilities.setWidgetWidthByPercentage(context, 28.8),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Image.network(
                    widget.category.image,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text(
                        'Ошибка загрузки изображения',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.underline,
                            fontSize: 12),
                      );
                    },
                  )),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SubCategoryPage(
                    subcategoryList: widget.category.subCategoryList,
                    categoryName: widget.category.name,
                  )));
        });
  }
}
