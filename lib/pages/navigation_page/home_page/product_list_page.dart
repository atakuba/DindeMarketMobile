import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/pages/navigation_page/home_page/filter_page.dart';
import 'package:dinde_market/provider/buttom_nav_bar_provider.dart';
import 'package:dinde_market/provider/products_provider.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:dinde_market/widgets/product_card_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListPage extends StatefulWidget {
  final int subCategoryID;
  final String subCategoryName;
  const ProductListPage(
      {super.key, required this.subCategoryID, required this.subCategoryName});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  String _sortOption = 'По умолчанию';
  RangeValues? _rangeValues;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.subCategoryName),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 0.1, color: const Color.fromRGBO(21, 19, 19, 1)),
                  ),
                  height: Utilities.setWidgetHeightByPercentage(context, 5.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: SizedBox(
                            width: Utilities.setWidgetWidthByPercentage(
                                context, 49),
                            child: Row(
                              children: [
                                Container(
                                    width: Utilities.setWidgetWidthByPercentage(
                                        context, 10),
                                    margin: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: Utilities
                                              .setWidgetWidthByPercentage(
                                                  context, 3.5),
                                          alignment: Alignment.centerRight,
                                          child: const Icon(
                                            Icons.north_outlined,
                                            size: 20,
                                          ),
                                        ),
                                        Container(
                                          width: Utilities
                                              .setWidgetWidthByPercentage(
                                                  context, 6.5),
                                          alignment: Alignment.centerLeft,
                                          child: const Icon(
                                            Icons.south_outlined,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    )),
                                const Text(
                                  "Сортировка",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(21, 19, 19, 1)),
                                )
                              ],
                            )),
                        onTap: () => showModal(
                            context: context,
                            sortBy: [
                              'Сначала подешевле',
                              'Сначала подороже',
                              'По алфавиту'
                            ],
                            sortByOptionSelected: (option) {
                              setState(() {
                                _sortOption = option;
                              });
                            }),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          return InkWell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              width: Utilities.setWidgetWidthByPercentage(
                                  context, 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text("Фильтры",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromRGBO(21, 19, 19, 1))),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: const Icon(Icons.sort_outlined),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () async {
                              ref
                                  .read(bottomNavBarVisibilityProvider.notifier)
                                  .state = false;
                              final RangeValues values =
                                  await Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => const FilterPage()));
                              setState(() {
                                _rangeValues = values;
                              });
                                                        },
                          );
                        },
                      )
                    ],
                  )),
            ),
            Expanded(
              flex: 23,
              child: Consumer(
                builder: (context, ref, child) {
                  return Container(
                      color: const Color.fromRGBO(244, 245, 249, 1),
                      padding: EdgeInsets.symmetric(
                          horizontal: Utilities.setWidgetWidthByPercentage(
                              context, 3.2)),
                      child: _rangeValues == null
                          ? _sortProductList(
                              sortOption: _sortOption,
                              subCategoryID: widget.subCategoryID,
                              ref: ref)
                          : _sortProductList(
                              sortOption: _sortOption,
                              subCategoryID: widget.subCategoryID,
                              values: _rangeValues,
                              ref: ref));
                },
              ),
            )
          ],
        )));
  }
}

Widget _sortProductList(
    {String? sortOption,
    RangeValues? values,
    required int subCategoryID,
    required WidgetRef ref}) {
  var filteredProducts = _productListItems(
      ref: ref, productFilter: 'category', subCategoryID: subCategoryID);
  List<Product> filterByPriceRange = [];
  if (values != null) {
    filterByPriceRange = filteredProducts
        .where((product) =>
            product.price >= values.start && product.price <= values.end)
        .toList();
    filterByPriceRange.sort((a, b) => a.name.compareTo(b.name));
    filteredProducts = filterByPriceRange;
  }
  if (sortOption == 'Сначала подешевле') {
    filteredProducts.sort((a, b) => a.price.compareTo(b.price));
  } else if (sortOption == 'Сначала подороже') {
    filteredProducts.sort((a, b) => a.price.compareTo(b.price));
    var descOrder = filteredProducts.reversed.toList();
    return ProductCardLayout.productCardLayout(productList: descOrder);
  } else if (sortOption == 'По алфавиту') {
    filteredProducts.sort((a, b) => a.name.compareTo(b.name));
  }
  return ProductCardLayout.productCardLayout(productList: filteredProducts);
}
// Widget _productCardLayout({required List<Product> productList}) {
//   return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: (100 / 150),
//         crossAxisSpacing: 1,
//         mainAxisSpacing: 3,
//       ),
//       scrollDirection: Axis.vertical,
//       itemCount: productList.length,
//       itemBuilder: (context, index) {
//         return ProductCard(product: productList[index]);
//       });
// }

List<Product> _productListItems(
    {required WidgetRef ref,
    required String productFilter,
    int? subCategoryID}) {
  final localProductList = ref.watch(productListProvider);

  if (productFilter == 'category') {
    return localProductList
        .where((category) => category.subCategory.id == subCategoryID)
        .toList();
  } else if (productFilter == 'news') {
    return localProductList
        .where((category) => category.subCategory.name == 'Новинки')
        .toList();
  } else if (productFilter == 'seasonal') {
    return localProductList
        .where((category) => category.subCategory.name == 'Сезонные продукты')
        .toList();
  } else if (productFilter == 'sales') {
    return localProductList
        .where((category) => category.subCategory.name == 'Акции')
        .toList();
  }
  return List.empty();
}

void showModal({
  required BuildContext context,
  List<String>? sortBy,
  required void Function(String) sortByOptionSelected,
}) {
  if (sortBy == null || sortBy.isEmpty) {
    return;
  }

  showModalBottomSheet(
    context: context,
    builder: (context) {
      double itemHeight = Utilities.setWidgetHeightByPercentage(context, 6.2);
      double totalHeight = itemHeight * sortBy.length;

      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            height: totalHeight + 50.0,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: const Text(
                    'Сортировать',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: sortBy.length,
                    separatorBuilder: (context, int) {
                      return const SizedBox.shrink();
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: Utilities.setWidgetWidthByPercentage(
                                  context, 5)),
                          height: itemHeight,
                          decoration: const BoxDecoration(),
                          child: Text(
                            sortBy[index],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                        onTap: () {
                          sortByOptionSelected(sortBy[index]);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

class FullScreenPageRoute extends PageRouteBuilder {
  final Widget page;

  FullScreenPageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
          fullscreenDialog: true,
        );
}

void showFullScreenOverlay(BuildContext context) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => const Positioned.fill(
      child: FilterPage(),
    ),
  );

  overlay.insert(overlayEntry);

  // Optionally, add a way to remove the overlay later
  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
