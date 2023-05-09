import 'dart:convert';

class Product {

  String? id;
  bool isAvailable;
  String name;
  String? imageUrl;
  double price;

  Product({
    this.id,
    required this.isAvailable,
    required this.name,
    this.imageUrl,
    required this.price,
  });

  factory Product.fromRawJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    isAvailable: json["isAvailable"],
    name: json["name"],
    imageUrl: json["imageUrl"],
    price: json["price"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "isAvailable": isAvailable,
    "name": name,
    "imageUrl": imageUrl,
    "price": price,
  };

  Product copy() => Product(
      id: id,
      isAvailable: isAvailable,
      name: name,
      imageUrl: imageUrl,
      price: price,
  );

}