import 'package:dinde_market/pages/navigation_page/home_page.dart';
import 'package:flutter/material.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => NavigationBarPageState();
}

class NavigationBarPageState extends State<NavigationBarPage> {
  int _selectedIndex = 0;
  static const List<Widget> _navigationBarDisplay = <Widget>[
    // HomePage(),
    Text("Favorite Page"),
    Text("Cart Page"),
    Text("Profile")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedLabelStyle: const TextStyle(
            fontSize: 10, color: Color.fromRGBO(138, 138, 142, 1)),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        items: [
          BottomNavigationBarItem(
              icon: _selectedIndex == 0
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
              icon: _selectedIndex == 1
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
              icon: _selectedIndex == 2
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
              icon: _selectedIndex == 3
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
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            HomePage(),
            Container(color: Colors.lightBlue,),
            Container(color: Colors.lightGreen,),
            Container(color: Colors.pink,),
          ],
        ),
        // child: _navigationBarDisplay.elementAt(_selectedIndex),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
