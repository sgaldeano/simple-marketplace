import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {

  final String? imagePath;

  const ProductImage({Key? key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageDecoration = BoxDecoration(
      color: Colors.black,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20)
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 5)
        )
      ]
    );

    return Container(
      height: 450,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: imageDecoration,
      child: Opacity(
        opacity: 0.86,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: ImageContainer(imagePath)
        ),
      )
    );
  }

}

class ImageContainer extends StatelessWidget {

  final String? imageLocation;

  const ImageContainer(
    this.imageLocation,
    {Key? key}
  ): super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageLocation == null) {
      return const Image(
        image: AssetImage('assets/no_image.png'),
        fit: BoxFit.cover
      );
    }

    if (imageLocation!.startsWith('http')) {
      return FadeInImage(
        placeholder: const AssetImage('assets/jar_loading.gif'),
        image: NetworkImage(imageLocation!),
        fit: BoxFit.cover
      );
    }

    return FadeInImage(
      placeholder: const AssetImage('assets/jar_loading.gif'),
      image: FileImage(File(imageLocation!)),
      fit: BoxFit.cover
    );

    // return Image.file(
    //   File(imageLocation!),
    //   fit: BoxFit.cover
    // );
  }

}