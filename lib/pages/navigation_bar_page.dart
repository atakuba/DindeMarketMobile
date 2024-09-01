import 'package:dinde_market/pages/navigation_page/cart_page/cart_page.dart';
import 'package:dinde_market/pages/navigation_page/favorite_page/favorite_page.dart';
import 'package:dinde_market/pages/navigation_page/home_page/home_page.dart';
import 'package:dinde_market/provider/buttom_nav_bar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationBarPage extends ConsumerWidget {
  const NavigationBarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  int selectedIndex = ref.watch(selectedIndexProvider);
  bool bottomNavBarVisible = ref.watch(bottomNavBarVisibilityProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      bottomNavigationBar: Visibility(
        visible: bottomNavBarVisible,
        child: BottomNavigationBar(
        
        type: BottomNavigationBarType.fixed,
        onTap: (index) {ref.read(selectedIndexProvider.notifier).state = index; },
        currentIndex: selectedIndex,
        selectedLabelStyle: const TextStyle(
            fontSize: 10, color: Color.fromRGBO(138, 138, 142, 1)),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        items: [
          BottomNavigationBarItem(
              icon: selectedIndex == 0
                  ? const Icon(
                      Icons.home,
                      color: Color.fromRGBO(98, 175, 28, 1),
                    )
                  : const Icon(
                      Icons.home_outlined,
                      color: Color.fromRGBO(138, 138, 142, 1),
                    ),
              label: 'Главная'),
          BottomNavigationBarItem(
              icon: selectedIndex == 1
                  ? const Icon(
                      Icons.favorite,
                      color: Color.fromRGBO(98, 175, 28, 1),
                    )
                  : const Icon(
                      Icons.favorite_border_outlined,
                      color: Color.fromRGBO(138, 138, 142, 1),
                    ),
              label: 'Избранное'),
          BottomNavigationBarItem(
              icon: selectedIndex == 2
                  ? const Icon(
                      Icons.shopping_cart,
                      color: Color.fromRGBO(98, 175, 28, 1),
                    )
                  : const Icon(
                      Icons.shopping_cart_outlined,
                      color: Color.fromRGBO(138, 138, 142, 1),
                    ),
              label: 'Корзина'),
          BottomNavigationBarItem(
              icon: selectedIndex == 3
                  ? const Icon(
                      Icons.person,
                      color: Color.fromRGBO(98, 175, 28, 1),
                    )
                  : const Icon(
                      Icons.person_outline,
                      color: Color.fromRGBO(138, 138, 142, 1),
                    ),
              label: 'Профиль'),
        ],
      ),
      ) ,
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: selectedIndex,
          children: [
            HomePage(),
            const FavoritePage(),
            CartPage(),
            Container(color: Colors.pink,),
          ],
        ),
        // child: _navigationBarDisplay.elementAt(_selectedIndex),
      ),
    );
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
}
