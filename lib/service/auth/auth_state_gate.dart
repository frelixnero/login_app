import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../pages/home_page.dart';
import '../../pages/cart_page.dart';
import '../../pages/favorites_page.dart';
import '../../pages/profile_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [HomePage(), FavoritesPage(), CartPage(), ProfilePage()];
  }

  Widget _buildIcon(
    IconData icon,
    bool isActive,
    Color activeColor,
    Color inactiveColor,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: isActive ? activeColor : inactiveColor, size: 26),
        const SizedBox(height: 4),
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 3,
          width: isActive ? 18 : 0,
          decoration: BoxDecoration(
            color: isActive ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return [
      PersistentBottomNavBarItem(
        icon: _buildIcon(
          LucideIcons.home,
          _controller.index == 0,
          colorScheme.primaryContainer,
          colorScheme.outline,
        ),
        activeColorPrimary: colorScheme.primaryContainer,
        inactiveColorPrimary: colorScheme.outline,
      ),
      PersistentBottomNavBarItem(
        icon: _buildIcon(
          LucideIcons.heart,
          _controller.index == 1,
          colorScheme.primaryContainer,
          colorScheme.outline,
        ),
        activeColorPrimary: colorScheme.primaryContainer,
        inactiveColorPrimary: colorScheme.outline,
      ),
      PersistentBottomNavBarItem(
        icon: _buildIcon(
          LucideIcons.shoppingCart,
          _controller.index == 2,
          colorScheme.primaryContainer,
          colorScheme.outline,
        ),
        activeColorPrimary: colorScheme.primaryContainer,
        inactiveColorPrimary: colorScheme.outline,
      ),
      PersistentBottomNavBarItem(
        icon: _buildIcon(
          LucideIcons.bell,
          _controller.index == 3,
          colorScheme.primaryContainer,
          colorScheme.outline,
        ),
        activeColorPrimary: colorScheme.primaryContainer,
        inactiveColorPrimary: colorScheme.outline,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(context),
      backgroundColor: Theme.of(context).colorScheme.surface,
      confineToSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(16),
        colorBehindNavBar: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      navBarStyle: NavBarStyle.simple, // cleaner, custom-friendly layout
      onItemSelected: (index) {
        setState(() {
          _controller.index = index;
        });
      },
    );
  }
}
