import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/provider/cart_list_provider.dart';
import 'package:dinde_market/provider/favorite_list_provider.dart';
import 'package:dinde_market/provider/products_provider.dart';
import 'package:dinde_market/utility/utilities.dart';
import 'package:dinde_market/widgets/count_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _nextPage() {
    if (_currentPage < widget.product.photos.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 245, 249, 1),
      body: Consumer(
        builder: (context, ref, child) {
          final isFavorite = ref
              .watch(productListProvider)
              .where((p) => p.id == widget.product.id)
              .first
              .favorite;
          final isInCart = ref
              .watch(cartListNotifierProvider.notifier)
              .notInCart(widget.product);

          return Column(
            children: [
              Container(
                color: const Color.fromRGBO(255, 255, 255, 1),
                height: Utilities.setWidgetHeightByPercentage(context, 6),
              ),
              Expanded(
                flex: 42,
                child: Container(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.arrow_back_ios_outlined),
                      ),
                      const Text(
                        "Товар",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Utilities.setWidgetWidthByPercentage(
                                context, 4)),
                        child: InkWell(
                          child: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: Colors.red,
                          ),
                          onTap: () {
                            ref
                                .read(favoriteListNotifierProvider.notifier)
                                .toggleFavorite(widget.product);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 250,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: Utilities.setWidgetHeightByPercentage(
                            context, 37), // Height of the image slider
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount:
                              widget.product.photos.length, // Number of images
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index; // Update current page index
                            });
                          },
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // Full width for each image
                              child: Image.network(
                                widget.product.photos[index]
                                    .url, // Current image URL
                                fit: BoxFit.cover, // Cover the entire area
                              ),
                            );
                          },
                        ),
                      ),
                      // Previous button
                      if (_currentPage >
                          0) // Show only if there is a previous image
                        Positioned(
                          left: 10.0,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios,
                                color: const Color.fromARGB(255, 84, 222, 88),
                                size: 30), // Back arrow
                            onPressed: _previousPage,
                          ),
                        ),
                      // Next button
                      if (_currentPage <
                          widget.product.photos.length -
                              1) // Show only if there is a next image
                        Positioned(
                          right: 10.0,
                          child: IconButton(
                            icon: Icon(Icons.arrow_forward_ios,
                                color: Color.fromARGB(255, 84, 222, 88),
                                size: 30), // Next arrow
                            onPressed: _nextPage,
                          ),
                        ),
                    ],
                  )),
              Expanded(
                flex: 247,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          Utilities.setWidgetWidthByPercentage(context, 4.3)),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${widget.product.price} с/шт',
                          style: const TextStyle(
                              color: Color.fromRGBO(98, 175, 28, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 16),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.product.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(bottom: 8),
                        child: const Text(
                          'Описание товара',
                          style: TextStyle(
                              color: Color.fromRGBO(138, 138, 142, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(bottom: 18),
                        child: Text(
                          widget.product.description,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(77, 77, 80, 1)),
                        ),
                      ),
                      isInCart
                          ? InkWell(
                              child: Container(
                                alignment: Alignment.center,
                                width: Utilities.setWidgetWidthByPercentage(
                                    context, 95),
                                height: Utilities.setWidgetHeightByPercentage(
                                    context, 5),
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(98, 175, 28, 1),
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Text(
                                  "В корзину",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              onTap: () {
                                ref
                                    .read(cartListNotifierProvider.notifier)
                                    .amountIncrement(widget.product);
                              },
                            )
                          : CountCard(product: widget.product)
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
