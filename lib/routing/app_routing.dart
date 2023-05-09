import 'package:flutter/material.dart';
import '../pages/pages.dart';

class AppRouting {

  static const String initialRoute = LoginPage.routeName;

  static final Map<String, Widget Function(BuildContext)> routes = {
    LoginPage.routeName  : (_) => const LoginPage(),
    HomePage.routeName   : (_) => const HomePage(),
    ProductPage.routeName: (_) => const ProductPage()
  };

}