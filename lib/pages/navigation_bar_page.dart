import 'package:dinde_market/pages/navigation_page/cart_page/cart_page.dart';
import 'package:dinde_market/pages/navigation_page/favorite_page/favorite_page.dart';
import 'package:dinde_market/pages/navigation_page/home_page/home_page.dart';
import 'package:dinde_market/pages/navigation_page/profile_page/profile_page.dart';
import 'package:dinde_market/provider/buttom_nav_bar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationBarPage extends ConsumerStatefulWidget {
  const NavigationBarPage({super.key});

  @override
  _NavigationBarPageState createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends ConsumerState<NavigationBarPage> {
  DateTime? _lastPressed; // To track the time of the last click

  // Method to reload HomePage
  void _reloadHomePage() {
    setState(() {
      Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NavigationBarPage()));
    });
  }

  void _onNavBarTapped(int index) {
    DateTime now = DateTime.now();
    int selectedIndex = ref.read(selectedIndexProvider);

    if (index == 0) { // Check if the Home tab is tapped
      if (selectedIndex == 0) {
        if (_lastPressed != null &&
            now.difference(_lastPressed!) < Duration(milliseconds: 300)) {
          // Double click detected: Reload HomePage
          _reloadHomePage();
        } else {
          // Single click: Track the time but don't reload
          _lastPressed = now;
        }
      } else {
        // If switching to Home page, just update the tab
        ref.read(selectedIndexProvider.notifier).state = 0;
        _lastPressed = now; // Reset the last press time for Home tab
      }
    } else {
      // Handle other tabs as usual (no double click logic)
      ref.read(selectedIndexProvider.notifier).state = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = ref.watch(selectedIndexProvider);
    bool bottomNavBarVisible = ref.watch(bottomNavBarVisibilityProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      bottomNavigationBar: Visibility(
        visible: bottomNavBarVisible,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _onNavBarTapped, // Handle taps here
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
      ),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: selectedIndex,
          children: const [
            HomePage(),
            FavoritePage(),
            CartPage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
