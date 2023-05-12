import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import '../models/models.dart' show Product;
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {

  final String _baseUrl = 'flutter-varios-95e39-default-rtdb.firebaseio.com';
  final String _cloudinaryUrl = 'https://api.cloudinary.com/v1_1/dnhbcqkoy/image/upload?upload_preset=Flutter-Upload';
  final List<Product> products = [];
  late Product selectedProduct;

  File? productImageFile;

  bool isLoading = true;
  bool isSaving = false;

  ProductsService() {
    loadProducts();
  }

  Future loadProducts() async {
    isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.https(_baseUrl, 'products.json'));

    final Map<String, dynamic> productsMap = json.decode(response.body);

    productsMap.forEach((key, value) {
        final product = Product.fromMap(value);
        product.id = key;
        products.add(product);
      }
    );

    isLoading = false;
    notifyListeners();
  }

  Future updateOrCreateProduct() async {
    isSaving = true;
    notifyListeners();

    final String? imageUrl = await _uploadImage();
    if (imageUrl != null) {
      selectedProduct.imageUrl = imageUrl;
    }

    if (selectedProduct.id == null) {
      await createProduct();
    } else {
      await updateProduct();
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> createProduct() async {
    final Uri url = Uri.https(_baseUrl, 'products.json');
    final response = await http.post(url, body: selectedProduct.toJson());

    selectedProduct.id = json.decode(response.body)['name'];
    products.add(selectedProduct);

    return selectedProduct.id!;
  }

  Future<String> updateProduct() async {
    final Uri url = Uri.https(_baseUrl, 'products/${selectedProduct.id}.json');
    await http.put(url, body: selectedProduct.toJson());

    final int updatedProductIndex = products.indexWhere((element) => selectedProduct.id == element.id);
    products[updatedProductIndex] = selectedProduct.copy();

    return selectedProduct.id!;
  }

  void updateSelectedProductImage(String imagePath) {
    selectedProduct.imageUrl = imagePath;
    productImageFile = File.fromUri(Uri(path: imagePath));

    notifyListeners();
  }

  Future<String?> _uploadImage() async {
    if (productImageFile != null) {
      final Uri url = Uri.parse(_cloudinaryUrl);

      final imageUploadRequest = http.MultipartRequest('POST', url);
      final imageFile = await http.MultipartFile.fromPath('file', productImageFile!.path);
      imageUploadRequest.files.add(imageFile);

      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = json.decode(response.body);
        productImageFile = null;

        return decodedData['secure_url'];
      }

      return null;
    }

    return null;
  }

}