import 'package:flutter/material.dart';
import 'package:login_app/NavigationService/navigator_key.dart';
import 'package:login_app/models/resturant.dart';
import 'package:login_app/pages/splash_screen.dart';
import 'package:login_app/service/size_selector/size_selector_service.dart';
import 'package:login_app/themes/theme_provider.dart';
import 'package:login_app/util/responsive.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => Resturant()),
        ChangeNotifierProvider(create: (context) => SizeSelectorService()),
        ChangeNotifierProvider(create: (context) => Responsive()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: SplashScreen(),
    );
  }
}
