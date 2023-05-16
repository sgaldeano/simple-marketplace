import 'package:flutter/material.dart';
import '../pages/pages.dart';

class AppRouting {

  static const String initialRoute = AuthArbiterPage.routeName;

  static final Map<String, Widget Function(BuildContext)> routes = {
    AuthArbiterPage.routeName: (_) => const AuthArbiterPage(),
    LoginPage.routeName    : (_) => const LoginPage(),
    RegisterPage.routeName : (_) => const RegisterPage(),
    HomePage.routeName     : (_) => const HomePage(),
    ProductPage.routeName  : (_) => const ProductPage()
  };

}