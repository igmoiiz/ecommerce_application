import 'package:ecommerce_application/Categories/categories_services.dart';
import 'package:ecommerce_application/Checkout%20Pages/checkout_services.dart';
import 'package:ecommerce_application/Interface/Pages/interface_page.dart';
import 'package:ecommerce_application/Services/Authentication%20Services/auth_services.dart';

import 'package:ecommerce_application/Themes/theme.dart';
import 'package:ecommerce_application/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PersistentShoppingCart().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationServices()),
        ChangeNotifierProvider(create: (context) => CategoriesServices()),
        ChangeNotifierProvider(create: (context) => CheckoutServices()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop Breeze',
      theme: lightMode,
      darkTheme: darkMode,
      home: const InterfacePage(),
    );
  }
}
