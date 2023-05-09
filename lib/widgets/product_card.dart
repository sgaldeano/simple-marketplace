import 'package:flutter/material.dart';
import '../models/models.dart';
import '../themes/app_themes.dart';

class ProductCard extends StatelessWidget {

  final Product product;

  const ProductCard({
    Key? key,
    required this.product
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: Offset(0, 7)
        )
      ]
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      height: 400,
      decoration: cardDecoration,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          _BackgroundImage(product.imageUrl),

          _ProductUpperTag(product.price.toString()),

          _ProductLowerTag(title: product.name, subtitle: product.id),

          if (!product.isAvailable)
            const _NotAvailableIndicator()
        ],
      )
    );
  }

}

class _BackgroundImage extends StatelessWidget {
  
  final String? imageUrl;

  const _BackgroundImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: imageUrl != null
          ? FadeInImage(
            placeholder: const AssetImage('assets/jar_loading.gif'),
            image: NetworkImage(imageUrl!),
            fit: BoxFit.cover,
          )
          : const FadeInImage(
            placeholder: AssetImage('assets/jar_loading.gif'),
            image: AssetImage('assets/no_image.png'),
            fit: BoxFit.cover,
          ),
      )
    );
  }

}

class _ProductUpperTag extends StatelessWidget {
  
  final String text;

  const _ProductUpperTag(this.text);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        height: 60,
        decoration: _productTagDecoration,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: Text('\$$text',
            style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis
        )
      ),
    );
  }
}

class _ProductLowerTag extends StatelessWidget {

  final String title;
  final String? subtitle;

  const _ProductLowerTag({
    required this.title,
    this.subtitle
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(right: 50),
      decoration: _productTagDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis
          ),

          if (subtitle != null)
            Column(
              children: [
                const SizedBox(height: 3),
                Text(subtitle!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis
                )
              ]
            )
        ]
      )
    );
  }

}

class _NotAvailableIndicator extends StatelessWidget {

  const _NotAvailableIndicator();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        height: 60,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red[700],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)
          )
        ),
        child: const Text('Not available',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          )
        ),
      ),
    );
  }
}

const _productTagDecoration = BoxDecoration(
    color: AppThemes.primaryColor,
    borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        topRight: Radius.circular(20)
    )
);