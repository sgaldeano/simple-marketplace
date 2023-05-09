import 'package:flutter/material.dart';
import 'package:s12_products/themes/app_themes.dart';

class LoadingPage extends StatelessWidget {

  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products', style: TextStyle(color: Colors.white))
      ),
      body: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 10,
          color: AppThemes.primaryColor,
        )
      )
    );
  }

}