import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dinde_market/models/product.dart';

// StateProvider to manage the list of products
final productListProvider = StateProvider<List<Product>>((ref) => []);

// Method to update a product in the list
void updateProduct(WidgetRef ref, Product updatedProduct) {
  // Get the current list of products
  List<Product> currentList = ref.read(productListProvider).toList();

  // Find the index of the product you want to update
  int productIndex = currentList.indexWhere((product) => product.id == updatedProduct.id);

  if (productIndex != -1) {
    // Replace the old product with the updated product
    currentList[productIndex] = updatedProduct;

    // Update the productListProvider state with the new list
    ref.read(productListProvider.notifier).state = currentList;
  }
}

