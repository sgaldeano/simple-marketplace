import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routing/app_routing.dart';
import 'services/services.dart' show ProductsService, AuthService;
import 'themes/app_themes.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {

  const AppState({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsService()
        ),
        ChangeNotifierProvider(
            create: (_) => AuthService()
        )
      ],
      child: const MyApp()
    );
  }

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Products',
      initialRoute: AppRouting.initialRoute,
      routes: AppRouting.routes,
      theme: AppThemes.light
    );
  }

}