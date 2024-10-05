import 'package:dinde_market/config/database_configuration.dart';
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
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  FavoriteListNotifier(super.initialFavorites, this.ref) {
    ref.listen<List<Product>>(productListProvider, (_, productList) {
      // Update favorite list based on changes in the product list
      state = productList.where((product) => product.favorite).toList();
    });
  }
  
 void toggleFavorite(Product product) {

  final productListNotifier = ref.read(productListProvider.notifier);
  final productList = productListNotifier.state;
  if(!product.favorite) {
    addToFavorites(product.id, true);
  }else {
    removeFromFavorites(product.id);
  }

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

void addToFavorites(int productId, bool isFavorite) async {
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  
  Map<String, dynamic> row = {
    DatabaseHelper.columnId: productId,
    DatabaseHelper.columnFavorite: isFavorite ? 1 : 0,
  };

  int id = await dbHelper.insertProductFavorite(row);
  print("###################################");
  print("###################################");
  print("###################################");
  print("###################################");
  print('Inserted product into favorites with id: $id');
}

void removeFromFavorites(int productId) async {
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  
  int deletedCount = await dbHelper.deleteProductFavorite(productId);
  print("******************************");
  print("******************************");
  print("******************************");
  print("******************************");
  print('Deleted $deletedCount product(s) from favorites');
}



