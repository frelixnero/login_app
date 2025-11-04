import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:login_app/components/my_text_btn.dart';
import 'package:login_app/components/my_textfield.dart';
import 'package:login_app/components/text_icon_btn.dart';
import 'package:login_app/service/auth/auth_state_gate.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  final TextEditingController confirmpasswordcontroller =
      TextEditingController();

  void _showEmptyCartToast(BuildContext context) {
    print("Fill in the fields");
    DelightToastBar(
      builder: (context) {
        return ToastCard(
          color: Theme.of(context).colorScheme.errorContainer,

          title: Text(
            "Please fill in the fields",
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
    setState(() {});
  }

  void navigateToHome(BuildContext context) {
    print("Navigate");
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        );
      },
    );
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Close the dialog
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => AuthGate()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SafeArea(
        // 1. SingleChildScrollView is correct for keyboard handling
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    "Logo",
                    style: TextStyle(
                      fontSize: 31,
                      color: Theme.of(context).colorScheme.surface,
                      fontFamily: "Urbanist-Bold",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 50, left: 0, right: 0),
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Divider(
                        thickness: 5,
                        indent: 100,
                        endIndent: 100,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Hey there,",
                      style: TextStyle(
                        fontFamily: "Urbanist-Bold",
                        fontWeight: FontWeight.w700,
                        fontSize: 31,
                      ),
                    ),
                    const Text(
                      "Let's setup an account for you",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Text(
                      "Fill in the fields to begin your experience",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 50),

                    // email field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Email"),
                        MyTextField(
                          preIcon: const Icon(Iconsax.sms),
                          hintText: "Email",
                          obscureText: false,
                          controller: emailcontroller,
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // password field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Password"),
                        MyTextField(
                          preIcon: const Icon(Iconsax.lock),
                          hintText: "Password",
                          obscureText: true,
                          controller: passwordcontroller,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // password field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Confirm Password"),
                        MyTextField(
                          preIcon: const Icon(Iconsax.lock),
                          hintText: "Confirm Password",
                          obscureText: true,
                          controller: confirmpasswordcontroller,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 30),

                    MyTextBtn(
                      onTap: () {
                        if (passwordcontroller.text.isEmpty ||
                            emailcontroller.text.isEmpty) {
                          _showEmptyCartToast(context);
                        } else {
                          navigateToHome(context);
                        }
                      },
                      title: "Register",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        bottom: 10,
                        left: 15,
                        right: 15,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "or continue with",
                              style: TextStyle(
                                color: Color.fromARGB(255, 109, 108, 108),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextIconBtn(
                      buttonText: "Google",
                      onTap: () {},
                      borderColor: Theme.of(context).colorScheme.secondary,
                      borderWidth: 2,
                      containerColor: Theme.of(context).colorScheme.surface,
                      imagePath: "assets/google.png",
                      height: 30,
                      width: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10,
                        bottom: 20,
                        top: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already a member ?"),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              " Login now",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
