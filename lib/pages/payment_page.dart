import 'package:flutter/material.dart';
import 'package:login_app/components/my_receipt.dart';
import 'package:login_app/components/my_text_btn.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Page")),

      // The body now contains only the scrollable content (MyReceipt)
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Increased padding for content
          child: Column(
            // Note: mainAxisAlignment: MainAxisAlignment.spaceBetween is removed,
            // as the body is only responsible for the scrollable content.
            children: [
              MyReceipt(
                receiptHeader: "Thank you for your order",
                fontFamily: "Italics",
              ),
              // ... other content that should scroll with the receipt ...
            ],
          ),
        ),
      ),

      // Pin the 'Pay Now' button to the bottom using bottomNavigationBar
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          // Pushes the button above the system navigation bar/gestures
          bottom: MediaQuery.of(context).padding.bottom,
          left: 16.0,
          right: 16.0,
          top: 8.0, // Small margin above the button
        ),
        child: MyTextBtn(
          onTap: () {
            // Add your payment processing logic here
            print("Processing Payment...");
          },
          title: "Pay Now",
        ),
      ),
    );
  }
}
