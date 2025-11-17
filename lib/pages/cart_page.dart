import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:login_app/components/cart_tile.dart';
import 'package:login_app/components/reflex_btn.dart';
import 'package:login_app/models/resturant.dart';
import 'package:login_app/pages/payment_page.dart';
import 'package:provider/provider.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Function to show the empty cart toast
  void _showEmptyCartToast(BuildContext context) {
    DelightToastBar(
      builder: (context) {
        return ToastCard(
          color: Theme.of(context).colorScheme.errorContainer,

          title: Text(
            "Add Some Items To Your Cart",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onErrorContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Icon(
            Iconsax.info_circle,
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
        );
      },
      autoDismiss: true,
      position: DelightSnackbarPosition.top,
      snackbarDuration: const Duration(seconds: 1),
    ).show(context);
  }

  // Function to navigate to payment page
  void _navigateToPayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PaymentPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Resturant>(
      builder: (context, resturant, child) {
        // cart
        final userCart = resturant.cart;

        // scaffold ui
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            title: const Text(
              "Cart Page",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Sora-SemiBold",
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
            actions: [
              //  clear cart button
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: const Text(
                            'Are you sure you want clear all items',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 107, 107, 107),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                resturant.clearCart();
                              },
                              child: const Text(
                                "Clear",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 107, 107, 107),
                                ),
                              ),
                            ),
                          ],
                        ),
                  );
                },
                icon: const Icon(Icons.delete_rounded),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    userCart.isEmpty
                        ? Center(
                          child: Text(
                            "Your Cart is Empty",
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Sora-Bold",
                            ),
                          ),
                        )
                        : Expanded(
                          child: ListView.builder(
                            itemCount: userCart.length,
                            itemBuilder: (context, index) {
                              // get indvidual car item
                              final cartItem = userCart[index];
                              return MyCartTile(cartItem: cartItem);
                            },
                          ),
                        ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Price:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "\$ ${resturant.getTotalPrice().toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Sora-SemiBold",
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                  left: 10,
                  right: 10,
                ),
                child: ReflexButton(
                  onTap: () {
                    if (userCart.isEmpty) {
                      _showEmptyCartToast(context);
                    } else {
                      _navigateToPayment(context);
                    }
                  },
                  title: "CheckOut",
                  btnIcon: Iconsax.wallet_check,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
