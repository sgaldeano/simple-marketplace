import 'package:flutter/cupertino.dart';
import '../models/models.dart' show Product;

class ProductFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Product product;

  ProductFormProvider(this.product);

  setProductAvailability(bool isAvailable) {
    product.isAvailable = isAvailable;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

}