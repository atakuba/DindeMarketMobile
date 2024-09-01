import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/models/mock_data/mock_data.dart';

// Provider for the list of products
final productListProvider = StateProvider<List<Product>>((ref) => MyProducts.productList.toList());

// StateNotifierProvider for the list of favorite products
final favoriteListNotifierProvider = StateNotifierProvider<FavoriteListNotifier, List<Product>>((ref) {
  final productList = ref.watch(productListProvider);
  final favoriteProducts = productList.where((product) => product.favorite).toList();
  return FavoriteListNotifier(favoriteProducts, ref);
});

class FavoriteListNotifier extends StateNotifier<List<Product>> {
  final Ref ref;

  FavoriteListNotifier(super.initialFavorites, this.ref) {
    ref.listen<List<Product>>(productListProvider, (_, productList) {
      // Update favorite list based on changes in the product list
      state = productList.where((product) => product.favorite).toList();
    });
  }

  void toggleFavorite(Product product) {
    final productList = ref.read(productListProvider);

    // Update the favorite status of the product in the product list
    final updatedProductList = productList.map((p) {
      if (p.id == product.id) {
        return p.copyWith(favorite: !p.favorite);
      }
      return p;
    }).toList();

    // Update the product list provider with the new favorite status
    ref.read(productListProvider.notifier).state = updatedProductList;

    // Update the state with the new favorite list
    state = updatedProductList.where((p) => p.favorite).toList();
  }

  bool isFavorite(Product product) {
    return state.contains(product);
  }
}
