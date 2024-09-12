import 'package:dinde_market/provider/products_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dinde_market/models/product.dart';

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

  final productListNotifier = ref.read(productListProvider.notifier);
  final productList = productListNotifier.state;

  // Update the favorite status of the product in the product list
  final updatedProductList = productList.map((p) {
    if (p.id == product.id) {
      return p.copyWith(favorite: !p.favorite);
    }
    return p;
  }).toList();

  // Update the product list provider with the new favorite status
  productListNotifier.state = updatedProductList;
}


  bool isFavorite(Product product) {
    return state.contains(product);
  }
}
