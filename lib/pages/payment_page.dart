import 'package:flutter/material.dart';
import 'package:login_app/components/my_receipt.dart';
import 'package:login_app/components/my_text_btn.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment Page")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              MyReceipt(
                receiptHeader: "Thank you for your order",
                fontFamily: "Italics",
              ),
              // pay now
              MyTextBtn(onTap: () {}, title: "Pay Now"),
            ],
          ),
        ),
      ),
    );
  }
}
