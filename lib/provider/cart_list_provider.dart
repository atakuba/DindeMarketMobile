import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/provider/products_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifierProvider for the list of favorite products
final cartListNotifierProvider =
    StateNotifierProvider<CartListNotifier, List<Product>>((ref) {
  final productList = ref.watch(productListProvider);
  final cartProductList =
      productList.where((product) => product.count > 0).toList();
  return CartListNotifier(cartProductList, ref);
});

class CartListNotifier extends StateNotifier<List<Product>> {
  final Ref ref;

  CartListNotifier(super.initialFavorites, this.ref) {
    ref.listen<List<Product>>(productListProvider, (_, productList) {
      state = productList.where((product) => product.count > 0).toList();
    });
  }
  void countIncrement(Product product) {
    if (!state.contains(product)) {
      state.add(product);
    }
    final productListNotifier = ref.read(productListProvider.notifier);
    final productList = productListNotifier.state;

    // Update the count of the specified product
    final updatedProductList = productList.map((p) {
      if (p.id == product.id) {
        return p.copyWith(count: p.count + 1);
      }
      return p;
    }).toList();

    // Update the product list provider
    productListNotifier.state = updatedProductList;
  }

  int getTotalProductCount() {
    return state.fold(0, (total, p) => total + p.count);
  }

  int getTotalProductPrice() {
    return state.fold(0, (total, p) => total + (p.price.round() * p.count));
  }

  int getTotalDiscount() {
    return state.where((p) => p.discount != 0).fold(0, (total, p) => total + ((p.price * (p.discount/100)).round()*p.count));
  }

  int getTotalDiscountPrice() {
    return getTotalProductPrice() - getTotalDiscount();
  }

  void countDecrement(Product product) {
    if (product.count != 0) {
      final productListNotifier = ref.read(productListProvider.notifier);
      final productList = productListNotifier.state;

      // Update the count of the specified product
      final updatedProductList = productList.map((p) {
        if (p.id == product.id) {
          return p.copyWith(count: p.count - 1);
        }
        return p;
      }).toList();

      // Update the product list provider
      if (product.count < 1) {
        state.remove(product);
      }
      productListNotifier.state = updatedProductList;
    }
  }

  void removeProductFromCart(Product product) {
    final productListNotifier = ref.read(productListProvider.notifier);
      final productList = productListNotifier.state;

      // Update the count of the specified product
      final updatedProductList = productList.map((p) {
        if (p.id == product.id) {
          return p.copyWith(count: 0);
        }
        return p;
      }).toList();

      state.remove(product);
      productListNotifier.state = updatedProductList;
  }

void removeAllProductsFromCart(List<Product> productListInCart) {
  final productListNotifier = ref.read(productListProvider.notifier);

  final productList = productListNotifier.state;
  final updatedProductList = productList.map((p) => p.copyWith(count: 0)).toList();
  
  productListNotifier.state = updatedProductList;

  for (Product p in productListInCart) {
    if (!mounted) return; // Check again if the widget is still mounted
    state.remove(p);
  }

  state = updatedProductList.toList();
}


  int productFinalCount(Product prod) {
    return ref
        .watch(productListProvider)
        .firstWhere((p) => p.id == prod.id)
        .count;
  }

  bool notInCart(Product prod) {
    return ref
            .watch(productListProvider)
            .firstWhere((p) => p.id == prod.id)
            .count <
        1;
  }

  void addToCart(Product product) {
    final productListNotifier = ref.read(productListProvider.notifier);
    final productList = productListNotifier.state;

    // Update the favorite status of the product in the product list
    final updatedProductList = productList.map((p) {
      if (p.id == product.id) {
        return p.copyWith(count: product.count);
      }
      return p;
    }).toList();

    // Update the product list provider with the new favorite status
    productListNotifier.state = updatedProductList;

    // Update the state with the new favorite list
    state = updatedProductList.toList();
  }
}
