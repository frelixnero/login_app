import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:login_app/pages/cart_page.dart';
import 'package:login_app/pages/favorites_page.dart';
import 'package:login_app/pages/profile_page.dart';
import '../../pages/home_page.dart';

class AuthGate extends StatefulWidget {
  AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  int navBarIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const FavoritesPage(),
    const CartPage(),
    ProfilePage(),
  ];

  void navigateBottomBar(int index) {
    setState(() {
      navBarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: const EdgeInsets.only(top: 0, left: 1, right: 1, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: CurvedNavigationBar(
          index: navBarIndex,
          height: MediaQuery.of(context).size.height * 0.08,
          color: Theme.of(context).colorScheme.primaryContainer,
          backgroundColor: Theme.of(context).colorScheme.surface,
          animationDuration: const Duration(milliseconds: 300),
          onTap: navigateBottomBar,
          items: [
            Icon(Iconsax.home, color: Theme.of(context).colorScheme.background),
            Icon(
              Iconsax.heart,
              color: Theme.of(context).colorScheme.background,
            ),
            Icon(
              Iconsax.shopping_cart,
              color: Theme.of(context).colorScheme.background,
            ),
            Icon(Iconsax.user, color: Theme.of(context).colorScheme.background),
          ],
        ),
      ),
      body: IndexedStack(index: navBarIndex, children: _pages),
    );
  }
}
