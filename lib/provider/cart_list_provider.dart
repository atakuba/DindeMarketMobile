import 'package:dinde_market/config/database_configuration.dart';
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
    // List<int> productIdList = ref.watch(productListProvider.notifier).state.map((p) => p.id).toList();

    final productListNotifier = ref.read(productListProvider.notifier);
    final productList = productListNotifier.state;

    // Update the amount of the specified product
    final updatedProductList = productList.map((p) {
      if (p.id == product.id) {
        return p.copyWith(amount: p.amount + 1);
      }
      return p;
    }).toList();

    List<int> productIdList = state.map((p) => p.id).toList();
    if (!productIdList.contains(product.id)) {
      product.amount++;
      state.add(product);
      addToDbCart(product.id, product.amount);
    } else {
      product.amount++;
      updateCartDb(product.id, product.amount);
    }

    // Update the product list provider
    productListNotifier.state = updatedProductList;
  }

  double getTotalProductAmount() {
    return state.fold(0, (total, p) => total + p.amount);
  }

  double getTotalProductPrice() {
    return state.fold(0, (total, p) => total + (p.price.round() * p.amount));
  }

  double getTotalDiscount() {
    return state.where((p) => p.discount != 0).fold(
        0,
        (total, p) =>
            total + ((p.price * (p.discount / 100)).round() * p.amount));
  }

  double getTotalDiscountPrice() {
    return getTotalProductPrice() - getTotalDiscount();
  }

  void amountDecrement(Product product, int amount) {
    // product.amount = amount;
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
      amount -= 1;

      List<int> productIdList = state.map((p) => p.id).toList();
      if (productIdList.contains(product.id)) {
        updateCartDb(product.id, amount);
      }

      // Update the product list provider
      if (amount < 1) {
        removeFromDbCart(product.id);
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
    removeFromDbCart(product.id);

    state.remove(product);
    productListNotifier.state = updatedProductList;
  }

  void removeAllProductsFromCart(List<Product> productListInCart) {
    final productListNotifier = ref.read(productListProvider.notifier);

    final productList = productListNotifier.state;
    final updatedProductList =
        productList.map((p) => p.copyWith(amount: 0)).toList();

    productListNotifier.state = updatedProductList;
    removeAllFromDbCart();
    // for (Product p in productListInCart) {
    //   if (!mounted) return; // Check again if the widget is still mounted
    //   state.remove(p);
    // }

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

  void addToDbCart(int productId, int amount) async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;

    Map<String, dynamic> row = {
      DatabaseHelper.columnId: productId,
      DatabaseHelper.columnAmount: amount,
    };

    int id = await dbHelper.insertProductCart(row);
    print('Inserted product into cart with id: $id');
  }

  void updateCartDb(int productId, int amount) async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;

    int id = await dbHelper.updateProductCart(productId, amount);
    print("new product amount is $amount");
    print('updated product in cart with id: $id');
  }

  void removeFromDbCart(int productId) async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;

    int deletedCount = await dbHelper.deleteProductCart(productId);
    print("deleted with id $productId");
    print('Deleted $deletedCount product(s) from favorites');
  }

  void removeAllFromDbCart() async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;

    int deletedCount = await dbHelper.deleteAllProductCart();
    print("deleted all product form cart");
    print('Deleted $deletedCount product(s) from favorites');
  }
}

final deliveryPriceProvider = StateProvider<double>((ref) => 0);
