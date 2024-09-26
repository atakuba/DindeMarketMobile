import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/pages/navigation_page/home_page/filter_page.dart';
import 'package:dinde_market/provider/buttom_nav_bar_provider.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:dinde_market/widgets/product_card_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListPage extends StatefulWidget {
  final List<Product> productListDisplay;
  final String pageTitle;
  const ProductListPage(
      {super.key, required this.productListDisplay, required this.pageTitle});

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
          centerTitle: true,
          title: Text(widget.pageTitle),
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
                                          builder: (context) =>
                                              const FilterPage()));
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
                              productList: widget.productListDisplay,
                              ref: ref)
                          : _sortProductList(
                              sortOption: _sortOption,
                              productList: widget.productListDisplay,
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
    required List<Product> productList,
    required WidgetRef ref}) {
  List<Product> filterByPriceRange = [];
  if (values != null) {
    filterByPriceRange = productList
        .where((product) =>
            product.price >= values.start && product.price <= values.end)
        .toList();
    filterByPriceRange.sort((a, b) => a.name.compareTo(b.name));
    productList = filterByPriceRange;
  }
  if (sortOption == 'Сначала подешевле') {
    productList.sort((a, b) => a.price.compareTo(b.price));
  } else if (sortOption == 'Сначала подороже') {
    productList.sort((a, b) => a.price.compareTo(b.price));
    var descOrder = productList.reversed.toList();
    return ProductCardLayout.productCardLayout(productList: descOrder);
  } else if (sortOption == 'По алфавиту') {
    productList.sort((a, b) => a.name.compareTo(b.name));
  }
  return ProductCardLayout.productCardLayout(productList: productList);
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
                    separatorBuilder: (context, int1) {
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
