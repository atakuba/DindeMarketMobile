import 'package:dinde_market/models/mock_data/mock_data.dart';
import 'package:dinde_market/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for the list of products
final productListProvider = StateProvider<List<Product>>((ref) => MyProducts.productList.toList());

// StateNotifierProvider for the list of favorite products
final cartListNotifierProvider = StateNotifierProvider<CartListNotifier, List<Product>>((ref) {
  final productList = ref.watch(productListProvider);
  final cartProductList = productList.where((product) => product.quantity > 0).toList();
  return CartListNotifier(cartProductList, ref);
});

class CartListNotifier extends StateNotifier<List<Product>> {
  final Ref ref;

  CartListNotifier(super.initialFavorites, this.ref) {
    ref.listen<List<Product>>(productListProvider, (_, productList) {
      state = productList.where((product) => product.favorite).toList();
    });
  }

  void toggleFavorite(Product product) {
    if (state.contains(product)) {
      state.remove(product);
    } else{
      state.add(product);
    }
  }

  bool isFavorite(Product product) {
    return state.contains(product);
  }
  CartListNotifier favoriteListNotifierOf(WidgetRef ref) {
    return ref.read(cartListNotifierProvider.notifier);
  }
}
