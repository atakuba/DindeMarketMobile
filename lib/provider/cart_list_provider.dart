import 'package:dinde_market/models/product.dart';
import 'package:dinde_market/provider/products_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifierProvider for the list of favorite products
final cartListNotifierProvider =
    StateNotifierProvider<CartListNotifier, List<Product>>((ref) {
  final productList = ref.watch(productListProvider);
  final cartProductList =
      productList.where((product) => product.amount > 0).toList();
  return CartListNotifier(cartProductList, ref);
});

class CartListNotifier extends StateNotifier<List<Product>> {
  final Ref ref;

  CartListNotifier(super.initialFavorites, this.ref) {
    ref.listen<List<Product>>(productListProvider, (_, productList) {
      state = productList.where((product) => product.amount > 0).toList();
    });
  }
  void amountIncrement(Product product) {
    if (!state.contains(product)) {
      state.add(product);
    }
    final productListNotifier = ref.read(productListProvider.notifier);
    final productList = productListNotifier.state;

    // Update the amount of the specified product
    final updatedProductList = productList.map((p) {
      if (p.id == product.id) {
        return p.copyWith(amount: p.amount + 1);
      }
      return p;
    }).toList();

    // Update the product list provider
    productListNotifier.state = updatedProductList;
  }

  int getTotalProductAmount() {
    return state.fold(0, (total, p) => total + p.amount);
  }

  int getTotalProductPrice() {
    return state.fold(0, (total, p) => total + (p.price.round() * p.amount));
  }

  int getTotalDiscount() {
    return state.where((p) => p.discount != 0).fold(0, (total, p) => total + ((p.price * (p.discount/100)).round()*p.amount));
  }

  int getTotalDiscountPrice() {
    return getTotalProductPrice() - getTotalDiscount();
  }

  void amountDecrement(Product product, int amount) {
    product.amount = amount;
    if (product.amount != 0) {
      final productListNotifier = ref.watch(productListProvider.notifier);
      final productList = productListNotifier.state;

      // Update the amount of the specified product
      final updatedProductList = productList.map((p) {
        if (p.id == product.id) {
          return p.copyWith(amount: p.amount - 1);
        }
        return p;
      }).toList();

      // Update the product list provider
      if (product.amount < 1) {
        state.remove(product);
      }
      productListNotifier.state = updatedProductList;
    }
  }

  void removeProductFromCart(Product product) {
    final productListNotifier = ref.read(productListProvider.notifier);
      final productList = productListNotifier.state;

      // Update the amount of the specified product
      final updatedProductList = productList.map((p) {
        if (p.id == product.id) {
          return p.copyWith(amount: 0);
        }
        return p;
      }).toList();

      state.remove(product);
      productListNotifier.state = updatedProductList;
  }

void removeAllProductsFromCart(List<Product> productListInCart) {
  final productListNotifier = ref.read(productListProvider.notifier);

  final productList = productListNotifier.state;
  final updatedProductList = productList.map((p) => p.copyWith(amount: 0)).toList();
  
  productListNotifier.state = updatedProductList;

  for (Product p in productListInCart) {
    if (!mounted) return; // Check again if the widget is still mounted
    state.remove(p);
  }

  state = updatedProductList.toList();
}


  int productFinalAmount(Product prod) {
    return ref
        .watch(productListProvider)
        .firstWhere((p) => p.id == prod.id)
        .amount;
  }

  bool notInCart(Product prod) {
    return ref
            .watch(productListProvider)
            .firstWhere((p) => p.id == prod.id)
            .amount <
        1;
  }

  void addToCart(Product product) {
    final productListNotifier = ref.read(productListProvider.notifier);
    final productList = productListNotifier.state;

    // Update the favorite status of the product in the product list
    final updatedProductList = productList.map((p) {
      if (p.id == product.id) {
        return p.copyWith(amount: product.amount);
      }
      return p;
    }).toList();

    // Update the product list provider with the new favorite status
    productListNotifier.state = updatedProductList;

    // Update the state with the new favorite list
    state = updatedProductList.toList();
  }
}
